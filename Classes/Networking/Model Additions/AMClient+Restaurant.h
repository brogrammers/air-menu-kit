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

typedef void (^RestaurantCompletion) (AMRestaurant *restaurant, NSError *error);
typedef void (^RestaurantMenuCompletion) (AMMenu *menu, NSError *error);
typedef void (^RestaurantMenusCompletion) (NSArray *menus, NSError *error);

@interface AMClient (Restaurant)

-(NSURLSessionDataTask *)findRestaurantWithIdentifier:(NSString *)identifier
                                           completion:(RestaurantCompletion)completion;

-(NSURLSessionDataTask *)findMenusOfRestaurant:(AMRestaurant *)restaurant
                                    completion:(RestaurantMenusCompletion)completion;

-(NSURLSessionDataTask *)createMenuOfRestaurant:(AMRestaurant *)restaurant
                                       withName:(NSString *)name
                                         active:(BOOL)active
                                     completion:(RestaurantMenuCompletion)completion;

@end
