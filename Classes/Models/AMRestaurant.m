//
//  AMRestaurant.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMRestaurant.h"

@implementation AMRestaurant

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"loyalty" : @"loyalty",
             @"remoteOrder" : @"remote_order",
             @"conversionRate" : @"conversion_rate",
             @"address" : @"address",
             @"menu" : @"menu",
             @"location" : @"location",
             @"avatar" : @"avatar",
             @"rating" : @"rating",
             @"category" : @"category"};
}

+(NSValueTransformer *)addressJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMAddress class]];
}

+(NSValueTransformer *)menuJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMMenu class]];
}

+(NSValueTransformer *)avatarJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSString *avatarURL) {
        return [NSURL URLWithString:avatarURL];
    } reverseBlock:^id(NSURL *avatarURL) {
        return avatarURL.absoluteString;
    }];
}

+(NSValueTransformer *)locationJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSDictionary *location) {
        return [[AMLocation alloc] initWithLatitude:[location[@"latitude"] doubleValue] longitude:[location[@"longitude"] doubleValue]];
    } reverseBlock:^id(CLLocation *location) {
        return @{@"latitude" : @(location.coordinate.latitude),
                 @"longitude" : @(location.coordinate.longitude)};
    }];
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMRestaurant *)object identifier]] ||
        (!self.identifier && ![(AMRestaurant *)object identifier]);
    }
    return NO;}

-(NSUInteger)hash
{
    return [self.identifier hash];
}


@end
