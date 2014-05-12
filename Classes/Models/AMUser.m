//
//  AMUser.m
//  AirMenuKit
//
//  Created by Robert Lis on 09/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMUser.h"
#import "AMOAuthToken.h"
#import "AMOrder.h"
#import <ObjectiveSugar/ObjectiveSugar.h>

@implementation AMUser

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"username" : @"identity.username",
             @"email" : @"identity.email",
             @"type" : @"type",
             @"scopes" : @"scopes",
             @"phoneNumber" : @"phone",
             @"currentOrders" : @"current_orders",
             @"company" : @"company",
             @"unreadCount" : @"unread_count",
             @"avatar" : @"avatar"};
}

+(NSValueTransformer *)typeJSONTransformer
{
    return [MTLValueTransformer mtl_valueMappingTransformerWithDictionary:@{@"User" : @(AMUserTypeUser),
                                                                            @"Owner": @(AMUserTypeOwner),
                                                                            @"StaffMember" : @(AMUserTypeStaffMember)}];
}

+(NSValueTransformer *)companyJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMCompany class]];
}

+(NSValueTransformer *)currentOrdersJSONTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[AMOrder class]];
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
            if([AMOAuthToken scopesToNumberMapping][scopeString])
            {
                [transformed addObject:[AMOAuthToken scopesToNumberMapping][scopeString]];
            }
        }];
        return transformed;
    } reverseBlock:^id(NSArray *scopesEnums) {
        NSMutableArray *transformed = [NSMutableArray array];
        [scopesEnums each:^(NSNumber *scopeEnum) {
            if([AMOAuthToken numberToScopesMapping][scopeEnum])
            {
                [transformed addObject:[AMOAuthToken numberToScopesMapping][scopeEnum]];
            }
        }];
        return transformed;
    }];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMUser *)object identifier]] ||
        (!self.identifier && ![(AMUser *)object identifier]);
    }
    return NO;}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
