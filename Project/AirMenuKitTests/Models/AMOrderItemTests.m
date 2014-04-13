//
//  AMOrderItemTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <Mantle/Mantle.h>
#import "AMOrder.h"

SPEC_BEGIN(AMOrderItemTests)
describe(@"AMOrderItem", ^{
    context(@"object", ^{
        __block AMOrder *order;
        beforeAll(^{
            order = [[AMOrder alloc] init];
            [order setValuesForKeysWithDictionary:@{
                                                    
                                                    }];
        });
        
        it(@"sublcasses MTLModel", ^{
            [[order should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[order should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
       
        it(@"has identifier attribute", ^{
            
        });
    });
});
SPEC_END