//
//  AMCreditCard.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMCreditCard.h"

@implementation AMCreditCard
+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"cardType" : @"card_type",
             @"expiryMonth" : @"month",
             @"expiryYear" : @"year",
             @"number" : @"number",
             @"cvc" : @"cvc"};
}

-(BOOL)isEqual:(id)object
{
    if(self.class == [object class]) {
        return  [self.identifier isEqualToNumber:[(AMCreditCard *)object identifier]] ||
        (!self.identifier && ![(AMCreditCard *)object identifier]);
    }
    return NO;
}

-(NSUInteger)hash
{
    return [self.identifier hash];
}
@end
