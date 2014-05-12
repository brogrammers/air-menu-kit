//
//  AMCreditCardTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMCreditCard.h"
#import <objc/objc-runtime.h>
#import "NSDateFormatter+AirMenuTimestamp.h"
#import <Mantle/Mantle.h>

SPEC_BEGIN(AMCreditCardTests)
describe(@"AMCreditCard", ^{
    context(@"object", ^{
        __block AMCreditCard *card;
        
        beforeAll(^{
            card = [[AMCreditCard alloc] initWithDictionary:@{@"identifier" : @(1),
                                                              @"cardType" : @"VISA",
                                                              @"expiryMonth" : @"01",
                                                              @"expiryYear" : @"2009",
                                                              @"number" : @"12345"} error:nil];
        });
        
        
        it(@"subclasses MTLModel", ^{
            [[card should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms MTLJSONSerializing protocol", ^{
            [[card should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attributed", ^{
            [[card.identifier should] equal:@(1)];
        });
        
        it(@"has card type attributed", ^{
            [[card.cardType should] equal:@"VISA"];
        });
        
        it(@"has expiry month attributed", ^{
            [[card.expiryMonth should] equal:@"01"];
        });
        
        it(@"expiry year attribute", ^{
            [[card.expiryYear should] equal:@"2009"];
        });
        
        it(@"has number attributed", ^{
            [[card.number should] equal:@"12345"];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMCreditCard JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"cardType" : @"card_type",
                                              @"expiryMonth" : @"month",
                                              @"expiryYear" : @"year",
                                              @"number" : @"number"};
            [[mapping should] equal:expectedMapping];
        });
    });
    
    context(@"mapping", ^{
        __block AMCreditCard *card;
        __block NSDictionary *parsedNotificationJSON;
        
        beforeAll(^{
            parsedNotificationJSON = @{@"id": @1,
                                       @"card_type": @"MAESTRO",
                                       @"month": @"5",
                                       @"year": @"2009",
                                       @"number": @"12345"};
            card = [MTLJSONAdapter modelOfClass:[AMCreditCard class] fromJSONDictionary:parsedNotificationJSON error:nil];
        });
        
        it(@"maps notification JSON to AMNotification object", ^{
            [[card.identifier should] equal:@1];
            [[card.cardType should] equal:@"MAESTRO"];
            [[card.expiryMonth should] equal:@"5"];
            [[card.expiryYear should] equal:@"2009"];
            [[card.number should] equal:@"12345"];
        });
    });
});
SPEC_END