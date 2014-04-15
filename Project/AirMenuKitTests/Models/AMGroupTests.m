//
//  AMGroupTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMGroup.h"

SPEC_BEGIN(AMGroupTests)
describe(@"AMGroup", ^{
    
    context(@"object", ^{
        __block AMGroup *group;
        
        beforeAll(^{
            group = [AMGroup new];
            [group setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                    @"name" : @"a name"}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[group should] beKindOfClass:[AMGroup class]];
        });
        
        it(@"conforms to MTLJSONSerializer protocol", ^{
            [[group should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[group.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[group.name should] equal:@"a name"];
        });
        
        it(@"has device staff members attribute", ^{
            
        });
        
        it(@"has device attribute", ^{
            
        });
    });
    
    context(@"class", ^{
        
    });
    
    context(@"mapping", ^{
        
    });
});
SPEC_END