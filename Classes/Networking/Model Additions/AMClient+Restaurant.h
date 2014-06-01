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
#import "AMOpeningHour.h"
#import "AMReview.h"

typedef void (^RestaurantRangeCompletion) (NSArray *restaurants, NSError *error);
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
typedef void (^RestaurantOpeningHourCompletion) (AMOpeningHour *openingHour, NSError *error);
typedef void (^RestaurantOpeningHoursCompletion) (NSArray *openingHours, NSError *error);
typedef void (^RestaurantReviewsCompletion) (NSArray *reviews, NSError *error);
typedef void (^RestaurantReviewCompletion) (AMReview *review, NSError *error);

@interface AMClient (Restaurant)

/**
 *  GET /restaurants
 *  Find restaurants around geographical location
 *
 *  @param latitude   latittude of point
 *  @param longitude  longitude of point
 *  @param range      range in meters
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */

-(NSURLSessionDataTask *)findRestaurantsAtLatitude:(double)latitude
                                         longitude:(double)longitude
                                       withinRange:(double)range
                                        completion:(RestaurantRangeCompletion)completion;

/**
 *  GET /restaurants/:id
 *
 *  @param identifier identifier of restaurants
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findRestaurantWithIdentifier:(NSString *)identifier
                                           completion:(RestaurantCompletion)completion;


/**
 *  PUT /restaurants/:id
 *
 *  @param restaurant  restaurant to update - required
 *  @param name        new name of the restaurant
 *  @param category    new category of the restaurant
 *  @param description new description of the restaurant
 *  @param lineOne     new address line one of the restaurant
 *  @param lineTwo     new address line two of the restaurant
 *  @param city        new city of the restaurant
 *  @param county      new county of the restaurant
 *  @param state       new state of the restaurant
 *  @param country     new country of the restaurant
 *  @param latitude    new latitude of the restaurant
 *  @param longitude   new longitude of the restaurant
 *  @param avatar      new avatar of the restaurant
 *  @param completion  block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)updateRestaurant:(AMRestaurant *)restaurant
                              withNewName:(NSString *)name
                              newCategory:(NSString *)category
                           newDescription:(NSString *)description
                        newAddressLineOne:(NSString *)lineOne
                        newAddressLineTwo:(NSString *)lineTwo
                                  newCity:(NSString *)city
                                newCounty:(NSString *)county
                                 newState:(NSString *)state
                               newCountry:(NSString *)country
                              newLatitude:(double)latitude
                             newLongitude:(double)longitude
                                    image:(UIImage *)avatar
                            newCompletion:(RestaurantCompletion)completion;

/**
 *  DELETE /restaurants/:id
 *
 *  @param restaurant restaurant to delete - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */

-(NSURLSessionDataTask *)deleteRestaurant:(AMRestaurant *)restaurant
                               completion:(RestaurantCompletion)completion;

/**
 *  GET /restaurants/:id/menus
 *
 *  @param restaurant restaurant of menus
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findMenusOfRestaurant:(AMRestaurant *)restaurant
                                    completion:(RestaurantMenusCompletion)completion;

/**
 *  POST /restaurants/:id/menus
 *
 *  @param restaurant restaurant of menu - required
 *  @param name       menu name
 *  @param active     is menu active
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createMenuOfRestaurant:(AMRestaurant *)restaurant
                                       withName:(NSString *)name
                                         active:(BOOL)active
                                     completion:(RestaurantMenuCompletion)completion;


/**
 *  GET /restaurants/:id/devices
 *
 *  @param restaurant restaurant of devices -  required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findDevicesOfRestaurant:(AMRestaurant *)restaurant
                                      completion:(RestaurantDevicesCoompletion)completion;

/**
 *  POST /restaurants/:id/devices
 *
 *  @param restaurant restaurant to create device for - required
 *  @param name       name of the device
 *  @param uuid       uuid of the device
 *  @param token      token of the device
 *  @param platform   platform of the device
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createDeviceOfRestaurant:(AMRestaurant *)restaurant
                                         withName:(NSString *)name
                                             uuid:(NSString *)uuid
                                            token:(NSString *)token
                                         platform:(NSString *)platform
                                       completion:(RestaurantDeviceCompletion)completion;
/**
 *  GET /restaurants/:id/groups
 *
 *  @param restaurant restaurant of groups - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findGroupsOfRestaurant:(AMRestaurant *)restaurant
                                     completion:(RestaurantGroupsCompletion)completion;

/**
 *  POST /restaurants/:id/groups
 *
 *  @param restaurant restaurant if groups - required
 *  @param name       group name
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createGroupOfRestaurant:(AMRestaurant *)restaurant
                                        withName:(NSString *)name
                                      completion:(RestaurantGroupCompletion)completion;

/**
 *  GET restaurants/:id/orders
 *
 *  @param restaurant restaurant of orders - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */

-(NSURLSessionDataTask *)findOrdersOfRestaurant:(AMRestaurant *)restaurant
                                     completion:(RestaurantOrdersCompletion)completion;

/**
 *  POST restaurants/:id/orders
 *
 *  @param restaurant  restaurant to create order for - required
 *  @param tableNumber table number where order should be served
 *  @param completion  block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createOrderOfRestaurant:(AMRestaurant *)restaurant
                                   atTableNumber:(NSString *)tableNumber
                                      completion:(RestaurantOrderCompletion)completion;

/**
 *  GET restaurants/:id/staff_kinds
 *
 *  @param restaurant restaurant of staff kinds - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findStaffKindsOfRestaurant:(AMRestaurant *)restaurant
                                         completion:(RestaurantStaffKindsCompletion)completion;


/**
 *  POST /restaurants/:id/staff_kinds
 *
 *  @param restaurant        restaurant for create staff kind for - required
 *  @param name              name of staff kind
 *  @param acceptsOrders     can staff kind accept orders
 *  @param acceptsOrderItems can staff kind handle order items
 *  @param scopes            rights given to the staff kind
 *  @param completion        block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createStaffKindOfRestaurant:(AMRestaurant *)restaurant
                                            withName:(NSString *)name
                                        acceptOrders:(BOOL)acceptsOrders
                                   acceptsOrderItems:(BOOL)acceptsOrderItems
                                              scopes:(AMOAuthScope)scopes
                                          completion:(RestaurantStaffKindCompletion)completion;

/**
 *  GET /restaurants/:id/staff_members
 *
 *  @param restaurant restaurant of staff members - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */

-(NSURLSessionDataTask *)findStaffMembersOfRestaurant:(AMRestaurant *)restaurant
                                           completion:(RestaurantStaffMembersCompletion)completion;

/**
 *  POST /restaurants/:id/staff_members
 *
 *  @param restaurant          restaurant to create staff member for - required
 *  @param name                name of the staff member
 *  @param username            username of the staff member
 *  @param password            password of the staff member
 *  @param email               email of the staff member
 *  @param staffKindIdentifier identifier of staff kind this staff member belongs to
 *  @param avatar              image used as avatar for this staff member
 *  @param scopes              rights the staff member has within the system
 *  @param completion          block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createStaffMemberOfResstaurant:(AMRestaurant *)restaurant
                                               withName:(NSString *)name
                                               username:(NSString *)username
                                               password:(NSString *)password
                                                  email:(NSString *)email
                                              staffKind:(NSString *)staffKindIdentifier
                                                 avatar:(UIImage *)avatar
                                                 scopes:(AMOAuthScope)scopes
                                             completion:(RestaurantStaffMemberCompletion)completion;


/**
 *  GET /restaurant/:id/reviews
 *
 *  @param restaurant restaurant of reviews - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findReviewsOfRestaurant:(AMRestaurant *)restaurant
                                      completion:(RestaurantReviewsCompletion)completion;

/**
 *  POST /restaurants/:id/reviews
 *
 *  @param restaurant restaurant to create review for - required
 *  @param subject    title of review
 *  @param message    contents of the review
 *  @param rating     rating user has given 0-5
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createReviewOfRestaurant:(AMRestaurant *)restaurant
                                      withSubject:(NSString *)subject
                                          message:(NSString *)message
                                           rating:(NSInteger)rating
                                       completion:(RestaurantReviewCompletion)completion;

/**
 *  GET /restaurants/:id/opening_hours
 *
 *  @param restaurant restaurant of openinng hours - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findOpeningHoursOfRestaurant:(AMRestaurant *)restaurant
                                           completion:(RestaurantOpeningHoursCompletion)completion;

/**
 *  POST /restaurants/:id/opening_hours
 *
 *  @param restaurant restaurants to create opening hours for - required
 *  @param day        day of concern
 *  @param startDate  opening time
 *  @param endDate    close time
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createOpeningHourOfRestaurant:(AMRestaurant *)restaurant
                                                   day:(NSString *)day
                                                 start:(NSDate *)startDate
                                                   end:(NSDate *)endDate
                                            completion:(RestaurantOpeningHourCompletion)completion;

@end
