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
#import "AMOrder.h"
#import "AMOrderItem.h"
#import "AMGroup.h"
#import "AMStaffKind.h"
#import "AMStaffMember.h"
#import "AMDevice.h"
#import "AMNotification.h"
#import "AMCreditCard.h"
#import "AMReview.h"
#import "AMOpeningHour.h"

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
    
    it(@"returns a order when json root is order", ^{
        NSData *orderData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"order.json", nil)];
        NSDictionary *orderJSON = [NSJSONSerialization JSONObjectWithData:orderData options:0 error:nil];
        id order = [[AMObjectBuilder sharedInstance] objectFromJSON:orderJSON];
        [[order should] beKindOfClass:[AMOrder class]];
    });
    
    it(@"returns array of orders when json root is orders", ^{
        NSData *ordersData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"orders.json", nil)];
        NSDictionary *ordersJSON = [NSJSONSerialization JSONObjectWithData:ordersData options:0 error:nil];
        id orders = [[AMObjectBuilder sharedInstance] objectFromJSON:ordersJSON];
        [[orders should] beKindOfClass:[NSArray class]];
        [[[orders objectAtIndex:0] should] beKindOfClass:[AMOrder class]];
    });
    
    it(@"returns order item when json root is order_item", ^{
        NSData *orderItemData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"order_item.json", nil)];
        NSDictionary *orderItemJSON = [NSJSONSerialization JSONObjectWithData:orderItemData options:0 error:nil];
        id orderItem = [[AMObjectBuilder sharedInstance] objectFromJSON:orderItemJSON];
        [[orderItem should] beKindOfClass:[AMOrderItem class]];
    });
    
    it(@"returns array of order items when json root is order_items", ^{
        NSData *orderItemsData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"order_items.json", nil)];
        NSDictionary *orderItemsJSON = [NSJSONSerialization JSONObjectWithData:orderItemsData options:0 error:nil];
        id orderItems = [[AMObjectBuilder sharedInstance] objectFromJSON:orderItemsJSON];
        [[orderItems should] beKindOfClass:[NSArray class]];
        [[[orderItems objectAtIndex:0] should] beKindOfClass:[AMOrderItem class]];
    });
    
    it(@"returns group when json root is group ", ^{
        NSData *groupData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"group.json", nil)];
        NSDictionary *groupJSON = [NSJSONSerialization JSONObjectWithData:groupData options:0 error:nil];
        id group = [[AMObjectBuilder sharedInstance] objectFromJSON:groupJSON];
        [[group should] beKindOfClass:[AMGroup class]];
    });
    
    it(@"returns array of groups when json root is groups", ^{
        NSData *groupsData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"groups.json", nil)];
        NSDictionary *groupsJSON = [NSJSONSerialization JSONObjectWithData:groupsData options:0 error:nil];
        id groups = [[AMObjectBuilder sharedInstance] objectFromJSON:groupsJSON];
        [[groups should] beKindOfClass:[NSArray class]];
        [[[groups objectAtIndex:0] should] beKindOfClass:[AMGroup class]];
    });
    
    it(@"returns staff kind when json root is staff_kind", ^{
        NSData *staffKindData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"staff_kind.json", nil)];
        NSDictionary *staffKindJSON = [NSJSONSerialization JSONObjectWithData:staffKindData options:0 error:nil];
        id staffKind = [[AMObjectBuilder sharedInstance] objectFromJSON:staffKindJSON];
        [[staffKind should] beKindOfClass:[AMStaffKind class]];
    });
    
    it(@"returns array of staff kinds when json root is staff_kinds", ^{
        NSData *staffKindsData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"staff_kinds.json", nil)];
        NSDictionary *staffKindsJSON = [NSJSONSerialization JSONObjectWithData:staffKindsData options:0 error:nil];
        id staffKinds = [[AMObjectBuilder sharedInstance] objectFromJSON:staffKindsJSON];
        [[staffKinds should] beKindOfClass:[NSArray class]];
        [[[staffKinds objectAtIndex:0] should] beKindOfClass:[AMStaffKind class]];
    });
    
    it(@"returns staff member when json root is staff_member ", ^{
        NSData *staffMemberData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"staff_member.json", nil)];
        NSDictionary *staffMemberJSON = [NSJSONSerialization JSONObjectWithData:staffMemberData options:0 error:nil];
        id staffMember = [[AMObjectBuilder sharedInstance] objectFromJSON:staffMemberJSON];
        [[staffMember should] beKindOfClass:[AMStaffMember class]];
    });
    
    it(@"returns array of staff members when json staff_members", ^{
        NSData *staffMembersData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"staff_members.json", nil)];
        NSDictionary *staffMembersJSON = [NSJSONSerialization JSONObjectWithData:staffMembersData options:0 error:nil];
        id staffMembers = [[AMObjectBuilder sharedInstance] objectFromJSON:staffMembersJSON];
        [[staffMembers should] beKindOfClass:[NSArray class]];
        [[[staffMembers objectAtIndex:0] should] beKindOfClass:[AMStaffMember class]];
    });
    
    it(@"returns device when json root is device", ^{
        NSData *deviceData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"device.json", nil)];
        NSDictionary *deviceDataJSON = [NSJSONSerialization JSONObjectWithData:deviceData options:0 error:nil];
        id device = [[AMObjectBuilder sharedInstance] objectFromJSON:deviceDataJSON];
        [[device should] beKindOfClass:[AMDevice class]];
    });
    
    it(@"returns array of devices when json root is devices", ^{
        NSData *devicesData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"devices.json", nil)];
        NSDictionary *devicesJSON = [NSJSONSerialization JSONObjectWithData:devicesData options:0 error:nil];
        id devices = [[AMObjectBuilder sharedInstance] objectFromJSON:devicesJSON];
        [[devices should] beKindOfClass:[NSArray class]];
        [[[devices objectAtIndex:0] should] beKindOfClass:[AMDevice class]];
    });
    
    it(@"returns notification when json root is notification", ^{
        NSData *notificationData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"notification.json", nil)];
        NSDictionary *notificationJSON = [NSJSONSerialization JSONObjectWithData:notificationData options:0 error:nil];
        id notification = [[AMObjectBuilder sharedInstance] objectFromJSON:notificationJSON];
        [[notification should] beKindOfClass:[AMNotification class]];
    });
    
    it(@"returns aray notifications when json root is notificatons", ^{
        NSData *notificationsData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"notifications.json", nil)];
        NSDictionary *notificationsJSON = [NSJSONSerialization JSONObjectWithData:notificationsData options:0 error:nil];
        id notifications = [[AMObjectBuilder sharedInstance] objectFromJSON:notificationsJSON];
        [[notifications should] beKindOfClass:[NSArray class]];
        [[[notifications objectAtIndex:0] should] beKindOfClass:[AMNotification class]];
    });
    
    it(@"returns credit card when json root is notification", ^{
        NSData *creditCardData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"credit_card.json", nil)];
        NSDictionary *creditCardJSON = [NSJSONSerialization JSONObjectWithData:creditCardData options:0 error:nil];
        id creditCard = [[AMObjectBuilder sharedInstance] objectFromJSON:creditCardJSON];
        [[creditCard should] beKindOfClass:[AMCreditCard class]];
    });
    
    it(@"returns aray credit cards when json root is notificatons", ^{
        NSData *creditCardsData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"credit_cards.json", nil)];
        NSDictionary *creditCardsJSON = [NSJSONSerialization JSONObjectWithData:creditCardsData options:0 error:nil];
        id creditCards = [[AMObjectBuilder sharedInstance] objectFromJSON:creditCardsJSON];
        [[creditCards should] beKindOfClass:[NSArray class]];
        [[[creditCards objectAtIndex:0] should] beKindOfClass:[AMCreditCard class]];
    });
    
    it(@"returns review when json root is review", ^{
        NSData *reviewData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"review.json", nil)];
        NSDictionary *reviewJSON = [NSJSONSerialization JSONObjectWithData:reviewData options:0 error:nil];
        id review = [[AMObjectBuilder sharedInstance] objectFromJSON:reviewJSON];
        [[review should] beKindOfClass:[AMReview class]];
    });
    
    it(@"returns aray reviews when json root is reviews", ^{
        NSData *reviewsData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"reviews.json", nil)];
        NSDictionary *reviewsJSON = [NSJSONSerialization JSONObjectWithData:reviewsData options:0 error:nil];
        id reviews = [[AMObjectBuilder sharedInstance] objectFromJSON:reviewsJSON];
        [[reviews should] beKindOfClass:[NSArray class]];
        [[[reviews objectAtIndex:0] should] beKindOfClass:[AMReview class]];
    });
    
    it(@"returns opening hour when json root is opening_hour", ^{
        NSData *openingHourData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"opening_hour.json", nil)];
        NSDictionary *openingHourJSON = [NSJSONSerialization JSONObjectWithData:openingHourData options:0 error:nil];
        id openingHour = [[AMObjectBuilder sharedInstance] objectFromJSON:openingHourJSON];
        [[openingHour should] beKindOfClass:[AMOpeningHour class]];
    });
    
    it(@"returns aray opening hours when json root is opening hours", ^{
        NSData *openingHoursData = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"opening_hours.json", nil)];
        NSDictionary *openingHoursJSON = [NSJSONSerialization JSONObjectWithData:openingHoursData options:0 error:nil];
        id openingHours = [[AMObjectBuilder sharedInstance] objectFromJSON:openingHoursJSON];
        [[openingHours should] beKindOfClass:[NSArray class]];
        [[[openingHours objectAtIndex:0] should] beKindOfClass:[AMOpeningHour class]];
    });

});

SPEC_END