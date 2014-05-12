//
//  AMClient+User.h
//  AirMenuKit
//
//  Created by Robert Lis on 10/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMUser.h"
#import "AMDevice.h"
#import "AMNotification.h"
#import "AMOrder.h"
#import "AMOrderItem.h"
#import "AMCreditCard.h"

typedef void (^UserCompletion)(AMUser *user, NSError *error);
typedef void (^UserDevicesCompletion)(NSArray *devices, NSError *error);
typedef void (^UserDeviceCompletion)(AMDevice *device, NSError *error);
typedef void (^UserNotificationsCompletion)(NSArray *notifications, NSError *error);
typedef void (^UserOrderItemsCompletion)(NSArray *orderItems, NSError *error);
typedef void (^UserOrdersCompletion)(NSArray *orders, NSError *error);
typedef void (^UserNotificationCompletion)(AMNotification *notification, NSError *error);
typedef void (^UserCreditCardCompletion)(AMCreditCard *creditCard, NSError *error);
typedef void (^UserCreditCardsCompletion)(NSArray *creditCards, NSError *error);

@interface AMClient (User)

-(NSURLSessionDataTask *)findUserWithIdentifier:(NSString *)identifier
                                     completion:(UserCompletion)completion;

-(NSURLSessionDataTask *)createUserWithName:(NSString *)name
                                      email:(NSString *)email
                                      phone:(NSString *)phone
                                   username:(NSString *)username
                                   password:(NSString *)password
                                     avatar:(UIImage *)avatar
                                 completion:(UserCompletion)completion;


/*
 Current user
 */

-(NSURLSessionDataTask *)findCurrentUser:(UserCompletion)completion;

-(NSURLSessionDataTask *)updateCurrentUserWithNewName:(NSString *)name
                                          newPassword:(NSString *)password
                                             newEmail:(NSString *)email
                                       newPhoneNumber:(NSString *)phoneNumber
                                            newAvatar:(UIImage *)avatar
                                           completion:(UserCompletion)completion;

-(NSURLSessionDataTask *)findDevicesOfCurrentUser:(UserDevicesCompletion)completion;

-(NSURLSessionDataTask *)createDeviceOfCurrentUserWithName:(NSString *)name
                                                      uuid:(NSString *)uuid
                                                     token:(NSString *)token
                                                  platform:(NSString *)platform
                                                completion:(UserDeviceCompletion)completion;

-(NSURLSessionDataTask *)findNotificationsOfCurrentUser:(UserNotificationsCompletion)completion;

-(NSURLSessionDataTask *)findOrdersOfCurrentUserWithState:(AMOrderState)state
                                               completion:(UserOrdersCompletion)completion;

-(NSURLSessionDataTask *)findOrderItemsOfCurrentUserWithState:(AMOrderItemState)state
                                                   completion:(UserOrderItemsCompletion)completion;

-(NSURLSessionDataTask *)dismissNotifiation:(AMNotification *)notification
                    ofCurrentUserCompletion:(UserNotificationCompletion)completion;

-(NSURLSessionDataTask *)findCreditCardsOfCurentUserCompletion:(UserCreditCardsCompletion)completion;

-(NSURLSessionDataTask *)createCreditCardOfCurrentUserWithNumber:(NSString *)number
                                                        cardType:(NSString *)type
                                                     expiryMonth:(NSString *)month
                                                      expiryYear:(NSString *)year
                                                             cvc:(NSString *)cvc
                                                      completion:(UserCreditCardCompletion)completion;
@end
