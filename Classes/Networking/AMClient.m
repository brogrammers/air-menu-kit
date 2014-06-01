//
//  AirMenuClient.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMObjectBuilder.h"


static NSString * const JSONResponseSerializerWithDataKey = @"JSONResponseSerializerWithDataKey";

@interface JSONResponseSerializerWithData : AFJSONResponseSerializer
@end

@implementation JSONResponseSerializerWithData
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (*error != nil) {
            NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if(object)
            {
                userInfo[JSONResponseSerializerWithDataKey] = object;
            }
            NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
            (*error) = newError;
        }
        
        return (nil);
    }
    
    return ([super responseObjectForResponse:response data:data error:error]);
}
@end

@implementation AMClient
@synthesize errorHandlers = _errorHandlers;

-(NSDictionary *)errorHandlers
{
    if(!_errorHandlers)
    {
        _errorHandlers = [NSMutableDictionary dictionary];
    }

    return _errorHandlers;
}

-(void)registerHandler:(ErrorHandler)handler forErrorCode:(NSString *)code
{
    NSMutableDictionary *errorHandlers = (NSMutableDictionary *) self.errorHandlers;
    errorHandlers[code] = [handler copy];
}

-(void)executeHandlerForError:(NSError *)error
{
    NSInteger statusCode =[[[error userInfo] objectForKey:@"AFNetworkingOperationFailingURLResponseErrorKey"] statusCode];
    ErrorHandler handler = self.errorHandlers[[@(statusCode) description]];
    if(handler)
    {
        handler();
    }
}

+(instancetype)sharedClient
{
    static dispatch_once_t onceToken;
    static AMClient *sharedClient;
    dispatch_once(&onceToken, ^{
        sharedClient = [[AMClient alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        securityPolicy.allowInvalidCertificates = YES;
        sharedClient.securityPolicy = securityPolicy;
        sharedClient.responseSerializer = [JSONResponseSerializerWithData serializer];
        [sharedClient setSessionDidReceiveAuthenticationChallengeBlock:
         ^NSURLSessionAuthChallengeDisposition(NSURLSession *session,
                                               NSURLAuthenticationChallenge *challenge,
                                               NSURLCredential *__autoreleasing *credential) {
                                                    return NSURLSessionAuthChallengePerformDefaultHandling;
                                               }
         ];
    });
    return sharedClient;
}

-(NSURLSessionDataTask *)authenticateWithClientID:(NSString *)clientID
                                     clientSecret:(NSString *)clientSecret
                                         username:(NSString *)username
                                         password:(NSString *)password
                                           scopes:(AMOAuthScope)scopes
                                       completion:(AuthenticateCompletion)completion
{
    NSAssert(clientID, @"clientID cannot be nil");
    NSAssert(clientSecret, @"clientSecret cannot be nil");
    NSAssert(username, @"username cannot be nil");
    NSAssert(password, @"password cannot be nil");
    
    NSDictionary *params = @{@"grant_type" : @"password",
                             @"client_id" : clientID,
                             @"client_secret": clientSecret,
                             @"username" : username,
                             @"password" : password,
                             @"scope" : [AMOAuthToken stringFromOption:scopes]};
    
    return [self POST:@"/api/oauth2/access_tokens"
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSString *oldAccessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
                  if (oldAccessToken)
                  {
                      [[NSUserDefaults standardUserDefaults] setObject:nil forKey:oldAccessToken];
                  }
                  AMOAuthToken *token = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  [self.requestSerializer setValue:[@"Bearer " stringByAppendingString:token.token] forHTTPHeaderField:@"Authorization"];
                  [[NSUserDefaults standardUserDefaults] setObject:token.refreshToken forKey:@"refresh_token"];
                  [[NSUserDefaults standardUserDefaults] setObject:token.token forKey:@"access_token"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  if(completion) completion(token, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)refreshWithClientID:(NSString *)clientID
                                      secret:(NSString *)clientSecret
                                  completion:(AuthenticateCompletion)completion
{
    NSAssert(clientID, @"clientID cannot be nil");
    NSAssert(clientSecret, @"clientSecret cannot be nil");
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"];
    NSDictionary *params = @{@"grant_type" : @"refresh", @"client_id" : clientID, @"client_secret" : clientSecret, @"refresh_token" : token};
    return [self POST:@"/api/oauth2/access_tokens"
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  NSString *oldAccessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
                  AMOAuthToken *token = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if (oldAccessToken)
                  {
                      id userObject = [[NSUserDefaults standardUserDefaults] objectForKey:oldAccessToken];
                      [[NSUserDefaults standardUserDefaults] setObject:nil forKey:oldAccessToken];
                      if (userObject)
                      {
                          [[NSUserDefaults standardUserDefaults] setObject:userObject forKey:token.token];
                      }
                  }
                  [self.requestSerializer setValue:[@"Bearer " stringByAppendingString:token.token] forHTTPHeaderField:@"Authorization"];
                  [[NSUserDefaults standardUserDefaults] setObject:token.refreshToken forKey:@"refresh_token"];
                  [[NSUserDefaults standardUserDefaults] setObject:token.token forKey:@"access_token"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  if(completion) completion(token, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(BOOL)isLoggedIn
{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"access_token"];
    if(accessToken)
    {
        [self.requestSerializer setValue:[@"Bearer " stringByAppendingString:accessToken] forHTTPHeaderField:@"Authorization"];
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - HTTP method overrides to support common error handlers

-(NSURLSessionDataTask *)GET:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *tass, NSError *))failure
{
    return [super GET:URLString
           parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject){
                  NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                  if (urlResponse.statusCode == 200)
                  {
                      success(task, responseObject);
                  }
                  else
                  {
                      if(failure) failure(task, [NSError errorWithDomain:airMenuApiErrorDomain
                                                                    code:urlResponse.statusCode
                                                                userInfo:@{@"request" : task.originalRequest,
                                                                           @"response" : task.response}]);
                  }
              }
              failure:^(NSURLSessionDataTask *task, NSError *error){
                  [self executeHandlerForError:error];
                  if(failure) failure(task, error);
              }];
}


-(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
    constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *))failure
{
    return [super POST:URLString
            parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                  if(block) block(formData);
               }
               success:^(NSURLSessionDataTask *task, id responseObject) {
                  if(success) success(task, responseObject);
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                 [self executeHandlerForError:error];
                  if(failure) failure(task, error);
               }];
}


-(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *, id))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    return [super POST:URLString
            parameters:parameters
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
                   if (urlResponse.statusCode == 200 || urlResponse.statusCode == 201)
                   {
                       success(task, responseObject);
                   }
                   else
                   {
                       if(failure) failure(task, [NSError errorWithDomain:airMenuApiErrorDomain
                                                                     code:urlResponse.statusCode
                                                                 userInfo:@{@"request" : task.originalRequest,
                                                                            @"response" : task.response}]);
                   }
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                   [self executeHandlerForError:error];
                   if(failure) failure(task, error);
               }];
}

-(NSURLSessionDataTask *)PUT:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(NSURLSessionDataTask *, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    return [super PUT:URLString
           parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject){
                  if(success) success(task, responseObject);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error){
                  [self executeHandlerForError:error];
                  if(failure) failure(task, error);
              }];
}

-(NSURLSessionDataTask *)DELETE:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(NSURLSessionDataTask *, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    return [super DELETE:URLString
              parameters:parameters
                 success:^(NSURLSessionDataTask *task, id responseObject){
                     if(success) success(task, responseObject);
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error){
                    [self executeHandlerForError:error];
                     if(failure) failure(task, error);
                 }];
}

-(NSURLSessionDataTask *)PATCH:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSURLSessionDataTask *, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    return [super PATCH:URLString
             parameters:parameters
                success:^(NSURLSessionDataTask *task, id responseObject){
                    if(success) success(task, responseObject);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error){
                    [self executeHandlerForError:error];
                    if(failure) failure(task, error);
                }];
}
@end
 