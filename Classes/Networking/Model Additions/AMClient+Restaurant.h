//
//  AMClient+Restaurant.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMMenu.h"
#import "AMRestaurant.h"
#import "AMDevice.h"
#import "AMGroup.h"
#import "AMOrder.h"
#import "AMStaffKind.h"
#import "AMStaffMember.h"

typedef void (^RestaurantCompletion) (AMRestaurant *restaurant, NSError *error);
typedef void (^RestaurantMenuCompletion) (AMMenu *menu, NSError *error);
typedef void (^RestaurantMenusCompletion) (NSArray *menus, NSError *error);
typedef void (^RestaurantDevicesCoompletion) (NSArray *devices, NSError *error);
typedef void (^RestaurantDeviceCompletion) (AMDevice *device, NSError *error);
typedef void (^RestaurantGroupCompletion) (AMGroup *group, NSError *error);
typedef void (^RestaurantGroupsCompletion) (NSArray *groups, NSError *error);
typedef void (^RestaurantOrdersCompletion) (NSArray *orders, NSError *error);
typedef void (^RestaurantOrderCompletion) (AMOrder *order, NSError *error);
typedef void (^RestaurantStaffKindCompletion) (AMStaffKind *staffKind, NSError *error);
typedef void (^RestaurantStaffKindsCompletion) (NSArray *staffKinds, NSError *error);
typedef void (^RestaurantStaffMemberCompletion) (AMStaffMember *staffMember, NSError *error);
typedef void (^RestaurantStaffMembersCompletion) (NSArray *staffMembers, NSError *error);

@interface AMClient (Restaurant)

-(NSURLSessionDataTask *)findRestaurantWithIdentifier:(NSString *)identifier
                                           completion:(RestaurantCompletion)completion;


-(NSURLSessionDataTask *)updateRestaurant:(AMRestaurant *)restaurant
                              withNewName:(NSString *)name
                        newAddressLineOne:(NSString *)lineOne
                        newAddressLineTwo:(NSString *)lineTwo
                                  newCity:(NSString *)city
                                newCounty:(NSString *)county
                                 newState:(NSString *)state
                               newCountry:(NSString *)country
                              newLatitude:(double)latitude
                             newLongitude:(double)longitude
                            newCompletion:(RestaurantCompletion)completion;

-(NSURLSessionDataTask *)deleteRestaurant:(AMRestaurant *)restaurant
                               completion:(RestaurantCompletion)completion;

/*
 Restaurant > Menus
*/
-(NSURLSessionDataTask *)findMenusOfRestaurant:(AMRestaurant *)restaurant
                                    completion:(RestaurantMenusCompletion)completion;

-(NSURLSessionDataTask *)createMenuOfRestaurant:(AMRestaurant *)restaurant
                                       withName:(NSString *)name
                                         active:(BOOL)active
                                     completion:(RestaurantMenuCompletion)completion;


/*
Restaurants > Devices
*/

-(NSURLSessionDataTask *)findDevicesOfRestaurant:(AMRestaurant *)restaurant
                                      completion:(RestaurantDevicesCoompletion)completion;

-(NSURLSessionDataTask *)createDeviceOfRestaurant:(AMRestaurant *)restaurant
                                         withName:(NSString *)nameAM
                                             uuid:(NSString *)uuid
                                            token:(NSString *)token
                                         platform:(NSString *)platform
                                       completion:(RestaurantDeviceCompletion)completion;
/*
Restaurants > Groups
*/

-(NSURLSessionDataTask *)findGroupsOfRestaurant:(AMRestaurant *)restaurant
                                     completion:(RestaurantGroupsCompletion)completion;

-(NSURLSessionDataTask *)createGroupOfRestaurant:(AMRestaurant *)restaurant
                                        withName:(NSString *)name
                                      completion:(RestaurantGroupCompletion)completion;

/*
Restaurants > Orders
*/

-(NSURLSessionDataTask *)findOrdersOfRestaurant:(AMRestaurant *)restaurant
                                     completion:(RestaurantOrdersCompletion)completion;

-(NSURLSessionDataTask *)createOrderOfRestaurant:(AMRestaurant *)restaurant
                                      completion:(RestaurantOrderCompletion)completion;

/*
Restaurants > Staff Kinds
*/

-(NSURLSessionDataTask *)findStaffKindsOfRestaurant:(AMRestaurant *)restaurant
                                         completion:(RestaurantStaffKindsCompletion)completion;

-(NSURLSessionDataTask *)createStaffKindOfRestaurant:(AMRestaurant *)restaurant
                                            withName:(NSString *)name
                                        acceptOrders:(BOOL)acceptsOrders
                                   acceptsOrderItems:(BOOL)acceptsOrderItems
                                          completion:(RestaurantStaffKindCompletion)completion;
/*
Restaurants > Staff Members
 */

-(NSURLSessionDataTask *)findStaffMembersOfRestaurant:(AMRestaurant *)restaurant
                                           completion:(RestaurantStaffMembersCompletion)completion;

-(NSURLSessionDataTask *)createStaffMemberOfResstaurant:(AMRestaurant *)restaurant
                                               withName:(NSString *)name
                                               username:(NSString *)username
                                               password:(NSString *)password
                                                  email:(NSString *)email
                                              staffKind:(NSString *)staffKindIdentifier
                                             completion:(RestaurantStaffMemberCompletion)completion;

@end
