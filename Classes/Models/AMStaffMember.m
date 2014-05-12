//
//  StaffMember.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMStaffMember.h"
#import "AMOAuthToken.h"
#import <ObjectiveSugar/ObjectiveSugar.h>
@implementation AMStaffMember
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"username" : @"identity.username",
             @"email" : @"identity.email",
             @"scopes" : @"scopes",
             @"restaurant" : @"restaurant",
             @"device" : @"device",
             @"group" : @"group",
             @"kind" : @"staff_kind",
             @"avatar" : @"avatar"};
}

+(NSValueTransformer *)restaurantJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMRestaurant class]];
}

+(NSValueTransformer *)deviceJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMDevice class]];
}

+(NSValueTransformer *)groupJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMGroup class]];
}

+(NSValueTransformer *)kindJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMStaffKind class]];
}

+(NSValueTransformer *)avatarJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *avatarURL) {
        return [NSURL URLWithString:avatarURL];
    } reverseBlock:^id(NSURL *avatarURL) {
        return avatarURL.absoluteString;
    }];
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
        return  [self.identifier isEqualToNumber:[(AMStaffMember *)object identifier]] ||
        (!self.identifier && ![(AMStaffMember *)object identifier]);
    }
    return NO;}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
