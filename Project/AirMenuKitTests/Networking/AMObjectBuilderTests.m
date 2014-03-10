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
#import "AMMenuSection.h"
#import "AMMenuItem.h"
#import "AMUser.h"

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
    
    it(@"returns an array of menus when json root is menus", ^{
        NSData *menusJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"menus.json", nil)];
        NSDictionary *parsedMenusJSON = [NSJSONSerialization JSONObjectWithData:menusJSON options:0 error:nil];
        id menus = [[AMObjectBuilder sharedInstance] objectFromJSON:parsedMenusJSON];
        [[menus should] beKindOfClass:[NSArray class]];
        [[[menus objectAtIndex:0] should] beKindOfClass:[AMMenu class]];
        [[[menus objectAtIndex:1] should] beKindOfClass:[AMMenu class]];
        [[[menus objectAtIndex:2] should] beKindOfClass:[AMMenu class]];
    });
    
    it(@"returns a menu section when json root is menu section", ^{
        NSData *menuSectionJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"menu_section.json", nil)];
        NSDictionary *parsedMenuSectionJSON = [NSJSONSerialization JSONObjectWithData:menuSectionJSON options:0 error:nil];
        id menuSection = [[AMObjectBuilder sharedInstance] objectFromJSON:parsedMenuSectionJSON];
        [[menuSection should] beKindOfClass:[AMMenuSection class]];
    });
    
    it(@"returns array of menu sections when json root is menu sections", ^{
        NSData *menuSectionsData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"menu_sections.json", nil)];
        NSDictionary *parsedMenuSectionsJSON = [NSJSONSerialization JSONObjectWithData:menuSectionsData options:0 error:nil];
        id menuSections = [[AMObjectBuilder sharedInstance] objectFromJSON:parsedMenuSectionsJSON];
        [[menuSections should] beKindOfClass:[NSArray class]];
        [[[menuSections objectAtIndex:0] should] beKindOfClass:[AMMenuSection class]];
    });
    
    it(@"returns a menu item when json root is menu item", ^{
        NSData *menuItemData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"menu_item.json", nil)];
        NSDictionary *parsedMenuItemJSON = [NSJSONSerialization JSONObjectWithData:menuItemData options:0 error:nil];
        id menuItem = [[AMObjectBuilder sharedInstance] objectFromJSON:parsedMenuItemJSON];
        [[menuItem should] beKindOfClass:[AMMenuItem class]];
    });
    
    it(@"returns array of menu items when json root is menu items", ^{
        NSData *menuItemsData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"menu_items.json", nil)];
        NSDictionary *persedMenuItemsJSON = [NSJSONSerialization JSONObjectWithData:menuItemsData options:0 error:nil];
        id menuItems = [[AMObjectBuilder sharedInstance] objectFromJSON:persedMenuItemsJSON];
        [[menuItems should] beKindOfClass:[NSArray class]];
        [[[menuItems objectAtIndex:0] should] beKindOfClass:[AMMenuItem class]];
    });
    
    it(@"returns a user when json root is user", ^{
        NSData *userData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"user.json", nil)];
        NSDictionary *parsedUserJSON = [NSJSONSerialization JSONObjectWithData:userData options:0 error:nil];
        id user = [[AMObjectBuilder sharedInstance] objectFromJSON:parsedUserJSON];
        [[user should] beKindOfClass:[AMUser class]];
    });
    
    it(@"returns a user when json root is me", ^{
        NSData *meData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"me.json", nil)];
        NSDictionary *meUserJSON = [NSJSONSerialization JSONObjectWithData:meData options:0 error:nil];
        id me = [[AMObjectBuilder sharedInstance] objectFromJSON:meUserJSON];
        [[me should] beKindOfClass:[AMUser class]];
    });
});

SPEC_END