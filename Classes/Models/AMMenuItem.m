//
//  AMMenuItem.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMMenuItem.h"
#import "NSDateFormatter+AirMenuTimestamp.h"
#import "NSNumberFormatter+AirMenuNumberFormat.h"

@implementation AMMenuItem

#pragma mark - Mantle framework mapping hooks

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"details" : @"description",
             @"price" : @"price",
             @"currency" : @"currency",
             @"staffKind" : @"staff_kind",
             @"avatar" : @"avatar"};
}

+(NSValueTransformer *)staffKindJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMStaffKind class]];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMMenuItem *)object identifier]] ||
        (!self.identifier && ![(AMMenuItem *)object identifier]);
    }
    return NO;
}

+(NSValueTransformer *)avatarJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *avatarURL) {
        return [NSURL URLWithString:avatarURL];
    } reverseBlock:^id(NSURL *avatarURL) {
        return avatarURL.absoluteString;
    }];
}

-(NSUInteger)hash
{
    return [self.identifier hash];
}

@end
