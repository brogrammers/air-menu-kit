//
//  AMOrderItemTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <Mantle/Mantle.h>
#import "AMOrderItem.h"

SPEC_BEGIN(AMOrderItemTests)
describe(@"AMOrderItem", ^{
    context(@"object", ^{
        __block AMOrderItem *item;
        beforeAll(^{
            item = [[AMOrderItem alloc] init];
            [item setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                   @"comment" : @"a comment",
                                                   @"count" : @1,
                                                   @"state" : @"new",
                                                   @"approvedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"declinedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"prepareTimeStart" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"prepareTimeEnd" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"servedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"order" : [AMOrder new],
                                                   @"menuItem" : [AMMenuItem new]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[item should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing attribute", ^{
            [[item should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[item.identifier should] equal:@1];
        });
        
        it(@"has comment attribute", ^{
            [[item.comment should] equal:@"a comment"];
        });
        
        it(@"has count attribute", ^{
            [[item.count should] equal:@1];
        });
        
        it(@"has state attribute", ^{
            [[item.state should] equal:@"new"];
        });
        
        it(@"has approvedAt attribute", ^{
            [[item.approvedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has declinedAt attribute", ^{
            [[item.declinedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has prepareTimeStart attribute", ^{
            [[item.prepareTimeStart should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has prepareTimeEnd attribute", ^{
            [[item.prepareTimeEnd should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has servedAt attribute", ^{
            [[item.servedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has order attribute", ^{
            [[item.order should] equal:[AMOrder new]];
        });
        
        it(@"has menu item attribute", ^{
            [[item.menuItem should] equal:[AMMenuItem new]];
        });
    });
    
    context(@"class", ^{
        
    });
    
    context(@"mapping", ^{
        
    });
});
SPEC_END