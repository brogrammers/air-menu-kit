//
//  StaffKind.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMStaffKind.h"
#import "AMOAuthToken.h"

@implementation AMStaffKind
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"restaurant" : @"restaurant",
             @"scopes" : @"scopes"};
}

+(NSValueTransformer *)restaurantJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMRestaurant class]];
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
@end
