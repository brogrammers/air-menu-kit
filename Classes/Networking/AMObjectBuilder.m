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

static NSString *const kAMOAuthToken = @"access_token";
static NSString *const kAMCompany = @"company";
static NSString *const kAMRestaurant = @"restaurant";
static NSString *const kAMRestaurants = @"restaurants";
static NSString *const kAMMenu = @"menu";
static NSString *const kAMMenus = @"menus";


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
                            kAMMenu : [AMMenu class]};
    }
    return _classByJSONKey;
}

-(NSDictionary *)classByJSONArrayKey
{
    if (!_classByJSONArrayKey)
    {
        _classByJSONArrayKey = @{kAMRestaurants : [AMRestaurant class],
                                 kAMMenus : [AMMenu class]};
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
