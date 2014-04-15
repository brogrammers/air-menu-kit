//
//  AMObjectBuilder.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMObjectBuilder.h"
#import "AMOAuthToken.h"
#import "AMCompany.h"
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

static NSString *const kAMOAuthToken = @"access_token";
static NSString *const kAMCompany = @"company";
static NSString *const kAMRestaurant = @"restaurant";
static NSString *const kAMRestaurants = @"restaurants";
static NSString *const kAMMenu = @"menu";
static NSString *const kAMMenus = @"menus";
static NSString *const kAMMenuSection = @"menu_section";
static NSString *const kAMMenuSections = @"menu_sections";
static NSString *const kAMmenuItem = @"menu_item";
static NSString *const kAMMenuItems = @"menu_items";
static NSString *const kAMUser = @"user";
static NSString *const kAMMe = @"me";
static NSString *const kAMOrder = @"order";
static NSString *const kAMOrders = @"orders";
static NSString *const kAMOrderItem = @"order_item";
static NSString *const kAMOrderItems = @"order_items";
static NSString *const kAMGroup = @"group";
static NSString *const kAMGroups = @"groups";
static NSString *const kAMStaffKind = @"staff_kind";
static NSString *const kAMStaffKinds = @"staff_kinds";
static NSString *const kAMStaffMember = @"staff_member";
static NSString *const kAMStaffMembers = @"staff_members";
static NSString *const kAMDevice = @"device";
static NSString *const kAMDevices = @"devices";
static NSString *const kAMNotification = @"notification";
static NSString *const kAMNotifications = @"notifications";

@interface AMObjectBuilder()
@property (nonatomic, strong) NSDictionary *classByJSONKey;
@property (nonatomic, strong) NSDictionary *classByJSONArrayKey;
@end

@implementation AMObjectBuilder
+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static AMObjectBuilder *objectBuilder;
    dispatch_once(&onceToken, ^{
        objectBuilder = [AMObjectBuilder new];
    });
    return objectBuilder;
}

-(NSDictionary *)classByJSONKey
{
    if(!_classByJSONKey)
    {
        _classByJSONKey = @{kAMOAuthToken : [AMOAuthToken class],
                            kAMCompany : [AMCompany class],
                            kAMRestaurant : [AMRestaurant class],
                            kAMMenu : [AMMenu class],
                            kAMMenuSection : [AMMenuSection class],
                            kAMmenuItem : [AMMenuItem class],
                            kAMUser : [AMUser class],
                            kAMMe : [AMUser class],
                            kAMOrder : [AMOrder class],
                            kAMOrderItem : [AMOrderItem class],
                            kAMGroup : [AMGroup class],
                            kAMStaffKind : [AMStaffKind class],
                            kAMStaffMember : [AMStaffMember class],
                            kAMDevice : [AMDevice class],
                            kAMNotification : [AMNotification class]};
    }
    return _classByJSONKey;
}

-(NSDictionary *)classByJSONArrayKey
{
    if (!_classByJSONArrayKey)
    {
        _classByJSONArrayKey = @{kAMRestaurants : [AMRestaurant class],
                                 kAMMenus : [AMMenu class],
                                 kAMMenuSections : [AMMenuSection class],
                                 kAMMenuItems : [AMMenuItem class],
                                 kAMOrders : [AMOrder class],
                                 kAMOrderItems : [AMOrderItem class],
                                 kAMGroups : [AMGroup class],
                                 kAMStaffKinds : [AMStaffKind class],
                                 kAMStaffMembers : [AMStaffMember class],
                                 kAMDevices : [AMDevice class],
                                 kAMNotifications: [AMNotification class]};
    }
    return _classByJSONArrayKey;
}

-(id)objectFromJSON:(NSDictionary *)json
{
    NSString *type = json.allKeys.firstObject;
    if([[json valueForKey:type] isKindOfClass:[NSArray class]])
    {
        Class objectClass = self.classByJSONArrayKey[type];
        NSAssert(objectClass, @"Could not determine the class corresponding to the key in json");
        NSValueTransformer *transformer = [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:objectClass];
        return [transformer transformedValue:json[type]];
    }
    else
    {
        Class objectClass = self.classByJSONKey[type];
        NSAssert(objectClass, @"Could not determine the class corresponding to the key in json");
        
        NSError *error;
        id object = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:json[type] error:&error];
        if(error)
        {
            return nil;
        }
        else
        {
            return object;
        }
    }
}
@end
