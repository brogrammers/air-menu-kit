//
//  StaffKind.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMStaffKind.h"
#import "AMOAuthToken.h"
#import <ObjectiveSugar/ObjectiveSugar.h>
#import "AMStaffMember.h"

@implementation AMStaffKind
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"restaurant" : @"restaurant",
             @"scopes" : @"scopes",
             @"acceptsOrders" : @"accept_orders",
             @"acceptsOrderItems" : @"accept_order_items",
             @"members" : @"staff_members"};
}

+(NSValueTransformer *)restaurantJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMRestaurant class]];
}

+(NSValueTransformer *)membersJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AMStaffMember class]];
}

+(NSValueTransformer *)scopesJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSArray *scopesStrings) {
                NSMutableArray *transformed = [NSMutableArray array];
                [scopesStrings each:^(NSString *scopeString) {
                    [transformed addObject:[AMOAuthToken scopesToNumberMapping][scopeString]];
                }];
                return transformed;
            } reverseBlock:^id(NSArray *scopesEnums) {
                NSMutableArray *transformed = [NSMutableArray array];
                [scopesEnums each:^(NSNumber *scopeEnum) {
                    [transformed addObject:[AMOAuthToken numberToScopesMapping][scopeEnum]];
                }];
                return transformed;
            }];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMStaffKind *)object identifier]] ||
        (!self.identifier && ![(AMStaffKind *)object identifier]);
    }
    return NO;
}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
