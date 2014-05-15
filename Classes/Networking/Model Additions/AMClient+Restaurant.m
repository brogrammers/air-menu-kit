//
//  AMClient+Restaurant.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+Restaurant.h"
#import "AMObjectBuilder.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMClient (Restaurant)

-(NSURLSessionDataTask *)findRestaurantsAtLatitude:(double)latitude
                                         longitude:(double)longitude
                                       withinRange:(double)range
                                        completion:(RestaurantRangeCompletion)completion
{
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"0.00000000"];
    NSDictionary *params = @{@"latitude" : [numberFormatter stringFromNumber:@(latitude)],
                             @"longitude" : [numberFormatter stringFromNumber:@(latitude)],
                             @"offset" : @(range)};
    NSString *urlString = @"restaurants/";
    return [self GET:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *restaurants = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(restaurants, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

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
                            newCompletion:(RestaurantCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurant identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingString:restaurant.identifier.description];    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(name) [params setObject:name forKey:@"name"];
    if(description) [params setObject:description forKey:@"description"];
    if(lineOne) [params setObject:lineOne forKey:@"address_1"];
    if(lineTwo) [params setObject:lineTwo forKey:@"address_2"];
    if(city) [params setObject:city forKey:@"city"];
    if(county) [params setObject:county forKey:@"county"];
    if(country) [params setObject:country forKey:@"country"];
    if(state) [params setObject:state forKey:@"state"];
    if(latitude) [params setObject:@(latitude).description forKey:@"latitude"];
    if(longitude) [params setObject:@(longitude).description forKey:@"longitude"];
    if(category) [params setObject:category forKey:@"category"];
    
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
    NSAssert(name, @"name cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"menus"];
    NSMutableDictionary *params = [@{@"name" : name} mutableCopy];
    [params setObject:(active ? @YES : @NO) forKey:@"active"];
    return [self POST:urlString
           parameters:params
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
    NSAssert(name, @"name cannot be nil");
    NSAssert(uuid, @"uuid identifier cannot be nil");
    NSAssert(platform, @"platform identifier cannot be nil");
    NSMutableDictionary *params = [@{@"name" : name, @"uuid" : uuid, @"platform" : platform} mutableCopy];
    if(token) [params setObject:token forKey:@"token"];
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"devices"];
    return [self POST:urlString
           parameters:params
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
    NSAssert(name, @"name cannot be nil");
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
                                   atTableNumber:(NSString *)tableNumber
                                      completion:(RestaurantOrderCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"orders"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(tableNumber) [params setObject:tableNumber forKey:@"table_number"];
    return [self POST:urlString
           parameters:params
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
                                        acceptOrders:(BOOL)acceptsOrders
                                   acceptsOrderItems:(BOOL)acceptsOrderItems
                                              scopes:(AMOAuthScope)scopes
                                          completion:(RestaurantStaffKindCompletion)completion;
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSAssert(name, @"name cannot be nil");
    NSMutableDictionary *params = [@{@"name" : name,
                                    @"accept_orders" : acceptsOrders ? @"true" : @"false",
                                    @"accept_order_items" : acceptsOrderItems ? @"true" : @"false"} mutableCopy];
    if (scopes != AMOAuthScopeNone) [params setObject:[AMOAuthToken stringFromOption:scopes] forKey:@"scopes"];
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"staff_kinds"];
    return [self POST:urlString
           parameters:params
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
                                                 avatar:(UIImage *)avatar
                                                 scopes:(AMOAuthScope)scopes
                                             completion:(RestaurantStaffMemberCompletion)completion;
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSAssert(name, @"name cannot be nil");
    NSAssert(username, @"username cannot be nil");
    NSAssert(password, @"password cannot be nil");
    NSAssert(email, @"email cannot be nil");
    NSAssert(staffKindIdentifier, @"staff kind identifier cannot be nil");
    
    NSMutableDictionary *params = [@{@"name" : name,
                                    @"username" : username,
                                    @"password" : password,
                                    @"email" : email,
                                    @"staff_kind_id" : staffKindIdentifier} mutableCopy];
    if (scopes != AMOAuthScopeNone) [params setObject:[AMOAuthToken stringFromOption:scopes] forKey:@"scopes"];
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"staff_members"];

    if(avatar)
    {
        return [self POST:urlString
               parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    [formData appendPartWithFormData:UIImagePNGRepresentation(avatar) name:@"avatar"];
                  }
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      AMStaffMember *staffMember = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                      if(completion) completion(staffMember, nil);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      if(completion) completion(nil, error);
                  }];
    }
    else
    {
        return [self POST:urlString
               parameters:params
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      AMStaffMember *staffMember = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                      if(completion) completion(staffMember, nil);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      if(completion) completion(nil, error);
                  }];
    }
}

/*
 Restaurants > Reviews
 */

-(NSURLSessionDataTask *)findReviewsOfRestaurant:(AMRestaurant *)restaurant
                                      completion:(RestaurantReviewsCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"reviews"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *reviews = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(reviews, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createReviewOfRestaurant:(AMRestaurant *)restaurant
                                      withSubject:(NSString *)subject
                                          message:(NSString *)message
                                           rating:(NSInteger)rating
                                       completion:(RestaurantReviewCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSAssert(subject, @"subject cannot be nil");
    NSAssert(message, @"message cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"reviews"];
    NSDictionary *params = @{@"subject" : subject, @"message" : message, @"rating": @(rating)};
    return [self POST:urlString
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMReview *review = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(review, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

/*
 Restaurants > Opening Hours
 */

-(NSURLSessionDataTask *)findOpeningHoursOfRestaurant:(AMRestaurant *)restaurant
                                           completion:(RestaurantOpeningHoursCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"opening_hours"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *openingHours = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(openingHours, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createOpeningHourOfRestaurant:(AMRestaurant *)restaurant
                                                   day:(NSString *)day
                                                 start:(NSDate *)startDate
                                                   end:(NSDate *)endDate
                                            completion:(RestaurantOpeningHourCompletion)completion
{
    NSAssert(restaurant.identifier, @"restaurants identifier cannot be nil");
    NSAssert(day, @"day cannot be nil");
    NSAssert(startDate, @"start date cannot be nil");
    NSAssert(endDate, @"end date cannot ben nil");
    NSDictionary *params = @{@"day" : day,
                             @"start" : [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:startDate],
                             @"end" : [[NSDateFormatter sharedAirMenuFormatter] stringFromDate:endDate]};
    NSString *urlString = [@"restaurants/" stringByAppendingFormat:@"%@/%@", restaurant.identifier, @"opening_hours"];
    return [self POST:urlString
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMOpeningHour *openingHour = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(openingHour, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

@end
