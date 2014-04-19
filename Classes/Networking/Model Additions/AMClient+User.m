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

-(NSURLSessionDataTask *)updateCurrentUserWithNewName:(NSString *)name
                                          newPassword:(NSString *)password
                                       newPhoneNumber:(NSString *)phoneNumber
                                           completion:(UserCompletion)completion
{
    return [self POST:@"me"
           parameters:@{@"name" : name, @"password" : password, @"phone" : phoneNumber }
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(user, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)findDevicesOfCurrentUser:(UserDevicesCompletion)completion
{
    
    return [self GET:@"me/devices"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *devices = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(devices, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createDeviceOfCurrentUserWithName:(NSString *)name
                                                      uuid:(NSString *)uuid
                                                     token:(NSString *)token
                                                  platform:(NSString *)platform
                                                completion:(UserDeviceCompletion)completion
{
    return [self POST:@"me/devices"
           parameters:@{@"name" : name, @"uuid" : uuid, @"token" : token, @"platform" : platform}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMDevice *device = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(device, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)findNotificationsOfCurrentUser:(UserNotificationsCompletion)completion
{
    return [self GET:@"me/notifications"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *notifications = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(notifications, nil);

             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)findOrdersOfCurrentUserWithState:(AMOrderState)state
                                               completion:(UserOrdersCompletion)completion
{
    NSDictionary *states =  @{@(AMOrderStateNew) : @"new",
                              @(AMOrderStateOpen) : @"open",
                              @(AMOrderStateApproved) : @"approved",
                              @(AMOrderStateCancelled) : @"cancelled",
                              @(AMOrderStateServed) : @"served",
                              @(AMOrderStatePaid) : @"paid"};
    return [self GET:@"me/orders"
          parameters:@{@"state" : states[@(state)]}
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *orders = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(orders, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)findOrderItemsOfCurrentUserWithState:(AMOrderItemState)state
                                                   completion:(UserOrderItemsCompletion)completion
{
    NSDictionary *states = @{@(AMOrderItemStateNew) : @"new",
                             @(AMOrderItemStateApproved) : @"approved",
                             @(AMOrderItemStateDeclined) : @"declined",
                             @(AMOrderItemStateBeingPrepared) : @"start_prepare",
                             @(AMOrderItemStatePrepared) : @"end_prepare",
                             @(AMOrderItemStateServed) : @"served"};
    
    return [self GET:@"me/order_items"
          parameters:@{@"state" : states[@(state)]}
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *orderItems = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(orderItems, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)dismissNotifiation:(AMNotification *)notification
                    ofCurrentUserCompletion:(UserNotificationCompletion)completion
{
    NSAssert(notification.identifier, @"notifications identifier cannot be nil");
    NSString *urlString = [@"notifications/" stringByAppendingString:notification.identifier.description];
    return [self PUT:urlString
          parameters:@{@"read" : @(YES)}
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMNotification *notification = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(notification, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}


@end
