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
@end
