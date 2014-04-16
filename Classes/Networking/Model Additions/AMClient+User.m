//
//  AMClient+User.m
//  AirMenuKit
//
//  Created by Robert Lis on 10/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+User.h"
#import "AMObjectBuilder.h"
#import "NSDictionary+NullReplacement.h"

@implementation AMClient (User)
-(NSURLSessionDataTask *)findUserWithIdentifier:(NSString *)identifier
                                     completion:(UserCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"users/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(user, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if (completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)findCurrentUser:(UserCompletion)completion
{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    id userResponseObject = [[NSUserDefaults standardUserDefaults] objectForKey:accessToken];
    if(accessToken && userResponseObject)
    {
        AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:userResponseObject];
        if(completion) completion(user, nil);
        return nil;
    }
    else
    {
        return [self GET:@"me"
              parameters:nil
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                     NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
                     [[NSUserDefaults standardUserDefaults] setObject:[responseObject dictionaryByReplacingNullsWithBlanks] forKey:token];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                     if(completion) completion(user, nil);
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     if(completion) completion(nil, error);
                 }];
    }
}

-(NSURLSessionDataTask *)createUserWithName:(NSString *)name
                                   username:(NSString *)username
                                   password:(NSString *)password
                                 completion:(UserCompletion)completion

{
    NSAssert(name, @"name cannot be nil");
    NSAssert(username, @"username cannot be nil");
    NSAssert(password, @"password cannot be nil");
    return [self POST:@"users"
           parameters:@{@"name" : name, @"username" : username, @"password" : password}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(user, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)findDevicesOfCurrentUser:(UserDevicesCompletion)completiom
{
    return nil;
}

-(NSURLSessionDataTask *)createDeviceOfCurrentUserWithName:(NSString *)name
                                                      uuid:(NSString *)uuid
                                                     token:(NSString *)token
                                                  platform:(NSString *)platform
                                                completion:(UserDevicesCompletion)completion
{
    return nil;
}

-(NSURLSessionDataTask *)findNotificationsOfCurrentUser:(UserNotificationsCompletion)completion
{
    return nil;
}
@end
