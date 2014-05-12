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
    if(!accessToken)
    {
        completion(nil, [[NSError alloc] initWithDomain:@"com.air-menu.api" code:-1 userInfo:@{@"cause" : @"not logged in!!"}]);
        return nil;
    }
    
    id userResponseObject = [[NSUserDefaults standardUserDefaults] objectForKey:accessToken];
    if(userResponseObject)
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
                                      email:(NSString *)email
                                      phone:(NSString *)phone
                                   username:(NSString *)username
                                   password:(NSString *)password
                                     avatar:(UIImage *)avatar
                                 completion:(UserCompletion)completion;

{
    NSAssert(name, @"name cannot be nil");
    NSAssert(username, @"username cannot be nil");
    NSAssert(email, @"password cannot be nil");
    NSAssert(phone, @"password cannot be nil");
    NSAssert(password, @"password cannot be nil");
    NSDictionary *params = @{@"name" : name,
                             @"username" : username,
                             @"password" : password,
                             @"phone" : phone,
                             @"email" : email};
    if(avatar)
    {
        return [self POST:@"users"
               parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                        [formData appendPartWithFormData:UIImagePNGRepresentation(avatar) name:@"avatar"];
                  }
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                      if(completion) completion(user, nil);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      if(completion) completion(nil, error);
                  }];
    }
    else
    {
        return [self POST:@"users"
               parameters:params
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                      if(completion) completion(user, nil);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      if(completion) completion(nil, error);
                  }];
    }
}

-(NSURLSessionDataTask *)updateCurrentUserWithNewName:(NSString *)name
                                          newPassword:(NSString *)password
                                             newEmail:(NSString *)email
                                       newPhoneNumber:(NSString *)phoneNumber
                                            newAvatar:(UIImage *)avatar
                                           completion:(UserCompletion)completion
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(name) [params setObject:name forKey:@"name"];
    if(password) [params setObject:password forKey:@"password"];
    if(email) [params setObject:email forKey:@"email"];
    if(phoneNumber) [params setObject:phoneNumber forKey:@"phone"];
    if(avatar)
    {
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"PUT"
                                                                                   URLString:[[NSURL URLWithString:@"me" relativeToURL:self.baseURL] absoluteString]
                                                                                  parameters:params
                                                                   constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                       [formData appendPartWithFormData:UIImagePNGRepresentation(avatar) name:@"avatar"];
                                                                   } error:nil];
        NSURLSessionDataTask *task = [self dataTaskWithRequest:request
                                             completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
            if (error)
            {
                AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                if (completion) completion(user, error);
            }
            else
            {
                if (completion) completion(nil, error);
            }
        }];
        [task resume];
        return task;
    }
    else
    {
        return [self PUT:@"me"
              parameters:params
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     AMUser *user = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                     if(completion) completion(user, nil);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      if(completion) completion(nil, error);
                  }];
    }
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

-(NSURLSessionDataTask *)findCreditCardsOfCurentUserCompletion:(UserCreditCardsCompletion)completion
{
    return [self GET:@"me/credit_cards"
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *creditCards = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(creditCards, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createCreditCardOfCurrentUserWithNumber:(NSString *)number
                                                        cardType:(NSString *)type
                                                     expiryMonth:(NSString *)month
                                                      expiryYear:(NSString *)year
                                                             cvc:(NSString *)cvc
                                                      completion:(UserCreditCardCompletion)completion
{
    NSAssert(number, @"number cannot be nil");
    NSAssert(type, @"type cannot be nil");
    NSAssert(month, @"month cannot be nil");
    NSAssert(year, @"year cannot be nil");
    NSAssert(cvc, @"cvc cannot be nil");
    NSDictionary *params = @{@"number" : number, @"year" : year,  @"type" : type, @"month" : month, @"cvc" : cvc};
    return [self POST:@"me/credit_cards"
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMCreditCard *creditCard = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(creditCard, nil);
              } failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}
@end
