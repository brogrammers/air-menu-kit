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

/**
 *  GET /users
 *
 *  @param identifier identifier of user - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */

-(NSURLSessionDataTask *)findUserWithIdentifier:(NSString *)identifier
                                     completion:(UserCompletion)completion;

/**
 *  POST /users
 *
 *  @param name       users name
 *  @param email      users email
 *  @param phone      users phone number
 *  @param username   users username
 *  @param password   users password
 *  @param avatar     image used as users avatar
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
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

/**
 *  GET /me
 *
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findCurrentUser:(UserCompletion)completion;

/**
 *  PUT /me
 *
 *  @param name        new user name
 *  @param password    new user password
 *  @param email       new user email
 *  @param phoneNumber new user phone number
 *  @param avatar      new image used as user avatar
 *  @param completion  block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)updateCurrentUserWithNewName:(NSString *)name
                                          newPassword:(NSString *)password
                                             newEmail:(NSString *)email
                                       newPhoneNumber:(NSString *)phoneNumber
                                            newAvatar:(UIImage *)avatar
                                           completion:(UserCompletion)completion;

/**
 *  GET /me/devices
 *
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findDevicesOfCurrentUser:(UserDevicesCompletion)completion;

/**
 *  POST /me/devices
 *
 *  @param name       name of device
 *  @param uuid       uuid of device
 *  @param token      access token of device if present
 *  @param platform   platform of device (iOS, Android)
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createDeviceOfCurrentUserWithName:(NSString *)name
                                                      uuid:(NSString *)uuid
                                                     token:(NSString *)token
                                                  platform:(NSString *)platform
                                                completion:(UserDeviceCompletion)completion;

/**
 *  GET /me/notifications
 *
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findNotificationsOfCurrentUser:(UserNotificationsCompletion)completion;

/**
 *  GET /me/orders
 *
 *  @param state      state of orders of interest
 *  @param completion block exectuted upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findOrdersOfCurrentUserWithState:(AMOrderState)state
                                               completion:(UserOrdersCompletion)completion;

/**
 *  GET /me/order_items
 *
 *  @param state      state of order items of interest
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findOrderItemsOfCurrentUserWithState:(AMOrderItemState)state
                                                   completion:(UserOrderItemsCompletion)completion;

/**
 *  POST /me/notifications
 *
 *  @param notification notification to dismiss - required
 *  @param completion   block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)dismissNotifiation:(AMNotification *)notification
                    ofCurrentUserCompletion:(UserNotificationCompletion)completion;

/**
 *  GET /me/credit_cards
 *
 *  @param completion block exectuted upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findCreditCardsOfCurentUserCompletion:(UserCreditCardsCompletion)completion;

/**
 *  POST /me/credit_cards
 *
 *  @param number     credit card number
 *  @param type       credit card type (VISA, AMERICAN_EXPRESS)
 *  @param month      credit card month expiry
 *  @param year       credit card year expriry
 *  @param cvc        credit card cvc
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createCreditCardOfCurrentUserWithNumber:(NSString *)number
                                                        cardType:(NSString *)type
                                                     expiryMonth:(NSString *)month
                                                      expiryYear:(NSString *)year
                                                             cvc:(NSString *)cvc
                                                      completion:(UserCreditCardCompletion)completion;
@end
