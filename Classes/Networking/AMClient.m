//
//  AirMenuClient.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMObjectBuilder.h"

@implementation AMClient
+(instancetype)sharedClient
{
    static dispatch_once_t onceToken;
    static AMClient *sharedClient;
    dispatch_once(&onceToken, ^{
        sharedClient = [[AMClient alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        securityPolicy.allowInvalidCertificates = YES;
        sharedClient.securityPolicy = securityPolicy;
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
                                            scope:(NSString *)scope
                                          success:(void(^)(AMOAuthToken *token))success
                                          failure:(void(^)(NSError *error))failure;
{
    NSAssert(clientID, @"clientID cannot be nil");
    NSAssert(clientSecret, @"clientSecret cannot be nil");
    NSAssert(username, @"username cannot be nil");
    NSAssert(password, @"password cannot be nil");
    NSAssert(scope, @"scope cannot be nil");
    
    NSDictionary *params = @{@"grant_type" : @"password",
                             @"client_id" : clientID,
                             @"client_secret": clientSecret,
                             @"username" : username,
                             @"password" : password,
                             @"scope" : scope};
    
    return [self POST:@"/api/oauth2/access_tokens"
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMOAuthToken *token = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(success) success(token);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(failure) failure(error);
              }];
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
               failure:^(NSURLSessionDataTask *task, NSError *error) {
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
                    if(failure) failure(task, error);
                }];
}
@end
 