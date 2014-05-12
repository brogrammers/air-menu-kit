//
//  AMReview.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMReview.h"

@implementation AMReview
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"subject" : @"subject",
             @"message" : @"message",
             @"rating" : @"rating",
             @"user" : @"user"};
}

+(NSValueTransformer *)userJSONTransformer
{
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[AMUser class]];
}
@end
