//
//  AMObjectBuilderTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <objc/message.h>
#import "AMObjectBuilder.h"
#import "AMOAuthToken.h"
#import "AMRestaurant.h"
#import "AMMenu.h"

SPEC_BEGIN(AMObjectBuilderTests)

describe(@"AMObjectBuilder", ^{
    it(@"implements sharedInstance as singleton", ^{
       [[[AMObjectBuilder sharedInstance] should] beIdenticalTo:[AMObjectBuilder sharedInstance]];
    });
    
    it(@"returns AMOAuthToken", ^{
        NSDictionary *tokenParsedJSON = @{@"access_token" : @{}};
        id object =[[AMObjectBuilder sharedInstance] objectFromJSON:tokenParsedJSON];
        [[object should] beKindOfClass:[AMOAuthToken class]];
    });
    
    it(@"returns array of restaurants when json root is restaurants", ^{
        NSData *restaurantsJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"restaurants.json", nil)];
        NSDictionary *parsedRestaurantsJSON = [NSJSONSerialization JSONObjectWithData:restaurantsJSON options:0 error:nil];
        id restaurants = [[AMObjectBuilder sharedInstance] objectFromJSON:parsedRestaurantsJSON];
        [[restaurants should] beKindOfClass:[NSArray class]];
        [[[restaurants objectAtIndex:0] should] beKindOfClass:[AMRestaurant class]];
        [[[restaurants objectAtIndex:1] should] beKindOfClass:[AMRestaurant class]];
    });
    
    it(@"returns a restaurant when json root is restaurant", ^{
        NSData *restaurantJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"restaurant.json", nil)];
        NSDictionary *parsedRestaurantJSON = [NSJSONSerialization JSONObjectWithData:restaurantJSON options:0 error:nil];
        [[[[AMObjectBuilder sharedInstance] objectFromJSON:parsedRestaurantJSON ] should] beKindOfClass:[AMRestaurant class]];
    });
    
    it(@"returns a menu when json root is menu", ^{
        NSData *menuJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"menu.json", nil)];
        NSDictionary *parsedMenuJSON = [NSJSONSerialization JSONObjectWithData:menuJSON options:0 error:nil];
        [[[[AMObjectBuilder sharedInstance] objectFromJSON:parsedMenuJSON] should] beKindOfClass:[AMMenu class]];
    });
    
    it(@"retursn an array of menus when json root is menus", ^{
        NSData *menusJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"menus.json", nil)];
        NSDictionary *parsedMenusJSON = [NSJSONSerialization JSONObjectWithData:menusJSON options:0 error:nil];
        id menus = [[AMObjectBuilder sharedInstance] objectFromJSON:parsedMenusJSON];
        [[menus should] beKindOfClass:[NSArray class]];
        [[[menus objectAtIndex:0] should] beKindOfClass:[AMMenu class]];
        [[[menus objectAtIndex:1] should] beKindOfClass:[AMMenu class]];
        [[[menus objectAtIndex:2] should] beKindOfClass:[AMMenu class]];
    });
});

SPEC_END