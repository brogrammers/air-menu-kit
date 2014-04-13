//
//  AMOrderTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMOrder.h"

SPEC_BEGIN(AMOrderTests)
    context(@"object", ^{
        __block AMOrder *order;
        beforeAll(^{
            order = [[AMOrder alloc] init];
            [order setValuesForKeysWithDictionary:@{
                                                    @"identifier" : @1,
                                                    @"state" : @"new",
                                                    @"approvedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                    @"servedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                    @"cancelledAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                    @"restaurant" : [AMRestaurant new],
                                                    @"user" : [AMUser new]
                                                    }];
        });
        
        it(@"sublcasses MTLModel", ^{
            [[order should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[order should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[order.identifier should] equal:@1];
        });
        
        it(@"has state attribute", ^{
            [[order.state should] equal:@"new"];
        });
        
        it(@"has approved at attribute", ^{
            [[order.approvedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has servedAt attribute", ^{
            [[order.servedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"ha cancelledAt attribute", ^{
            [[order.cancelledAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has restaurant attribute", ^{
            [[order.restaurant should] equal:[AMRestaurant new]];
        });
        
        it(@"has user attribute", ^{
            [[order.user should] equal:[AMUser new]];
        });
    });
SPEC_END