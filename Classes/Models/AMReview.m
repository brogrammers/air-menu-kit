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

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMReview *)object identifier]] ||
        (!self.identifier && ![(AMReview *)object identifier]);
    }
    return NO;
}

-(NSUInteger)hash
{
    return [self.identifier hash];
}
@end
