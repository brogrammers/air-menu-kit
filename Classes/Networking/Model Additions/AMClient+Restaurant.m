//
//  AMClient+Restaurant.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+Restaurant.h"
#import "AMObjectBuilder.h"

@implementation AMClient (Restaurant)

-(NSURLSessionDataTask *)findRestaurantWithIdentifier:(NSString *)identifier
                                           completion:(RestaurantCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                AMRestaurant *restaurant = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                if(completion) completion(restaurant, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}


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
                            newCompletion:(RestaurantCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurant identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingString:restaurant.identifier.description];
    NSDictionary *params = @{@"name" : name,
                             @"address_1" : lineOne,
                             @"address_2" : lineTwo,
                             @"city" : city,
                             @"county" : county,
                             @"state" : state,
                             @"country" : country,
                             @"latitude" : @(latitude).description,
                             @"longitude" : @(longitude).description};
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMRestaurant *restaurant = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(restaurant, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)deleteRestaurant:(AMRestaurant *)restaurant
                               completion:(RestaurantCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurant identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingString:restaurant.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMRestaurant *restaurant = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(restaurant, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

/*
 Restaurant > Menus
 */

-(NSURLSessionDataTask *)findMenusOfRestaurant:(AMRestaurant *)restaurant
                                    completion:(RestaurantMenusCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@",restaurant.identifier, @"menus"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *menus = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(menus, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createMenuOfRestaurant:(AMRestaurant *)restaurant
                                       withName:(NSString *)name
                                         active:(BOOL)active
                                     completion:(RestaurantMenuCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"menus"];
    return [self POST:urlString
           parameters:@{@"name" : name, @"active" : (active ? @YES : @NO)}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMMenu *menu = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(menu, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}


/*
 Restaurants > Devices
 */

-(NSURLSessionDataTask *)findDevicesOfRestaurant:(AMRestaurant *)restaurant
                                      completion:(RestaurantDevicesCoompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"devices"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *devices = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(devices, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createDeviceOfRestaurant:(AMRestaurant *)restaurant
                                         withName:(NSString *)name
                                             uuid:(NSString *)uuid
                                            token:(NSString *)token
                                         platform:(NSString *)platform
                                       completion:(RestaurantDeviceCompletion)completion;
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"devices"];
    return [self POST:urlString
           parameters:@{@"name" : name, @"uuid" : uuid, @"token" : token, @"platform" : platform}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMDevice *device = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(device, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
    return nil;
}

/*
 Restaurants > Groups
 */

-(NSURLSessionDataTask *)findGroupsOfRestaurant:(AMRestaurant *)restaurant
                                     completion:(RestaurantGroupsCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"groups"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *groups = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(groups, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
    return nil;
}

-(NSURLSessionDataTask *)createGroupOfRestaurant:(AMRestaurant *)restaurant
                                        withName:(NSString *)name
                                      completion:(RestaurantGroupCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"groups"];
    return [self POST:urlString
           parameters:@{@"name" : name}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMGroup *group = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(group, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

/*
 Restaurants > Orders
 */

-(NSURLSessionDataTask *)findOrdersOfRestaurant:(AMRestaurant *)restaurant
                                     completion:(RestaurantOrdersCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"orders"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *orders = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(orders, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createOrderOfRestaurant:(AMRestaurant *)restaurant
                                      completion:(RestaurantOrderCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"orders"];
    return [self POST:urlString
           parameters:nil
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMOrder *order = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(order, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

/*
 Restaurants > Staff Kinds
 */

-(NSURLSessionDataTask *)findStaffKindsOfRestaurant:(AMRestaurant *)restaurant
                                         completion:(RestaurantStaffKindsCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"staff_kinds"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *array = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(array, nil);
             }
            failure:^(NSURLSessionDataTask *task, NSError *error) {
                if(completion) completion(nil, error);
            }];
}

-(NSURLSessionDataTask *)createStaffKindOfRestaurant:(AMRestaurant *)restaurant
                                            withName:(NSString *)name
                                          completion:(RestaurantStaffKindCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"staff_kinds"];
    return [self POST:urlString
           parameters:@{@"name" : name}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMStaffKind *staffKind = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(staffKind, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

/*
 Restaurants > Staff Members
 */

-(NSURLSessionDataTask *)findStaffMembersOfRestaurant:(AMRestaurant *)restaurant
                                           completion:(RestaurantStaffMembersCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"staff_members"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *staffMembers = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(staffMembers, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createStaffMemberOfResstaurant:(AMRestaurant *)restaurant
                                               withName:(NSString *)name
                                               username:(NSString *)username
                                               password:(NSString *)password
                                                  email:(NSString *)email
                                              staffKind:(NSString *)staffKindIdentifier
                                             completion:(RestaurantStaffMemberCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"staff_members"];
    return [self POST:urlString
           parameters:@{@"name" : name, @"username" : username, @"password" : password, @"email" : email, @"staff_kind_id" : staffKindIdentifier}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMStaffMember *staffMember = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(staffMember, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}


@end
