//
//  AMMenuSectionTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMMenuItem.h"
#import "AMMenuSection.h"
#import "NSDateFormatter+AirMenuTimestamp.h"
#import "NSNumberFormatter+AirMenuNumberFormat.h"


SPEC_BEGIN(AMMenuSectionTests)

describe(@"AMMenuSection", ^{
    context(@"object", ^{
        __block AMMenuSection *section;
        
        beforeAll(^{
            section = [[AMMenuSection alloc] init];
            [section setValuesForKeysWithDictionary:@{@"identifier" : @"1",
                                                      @"createdAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                      @"updatedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                      @"name" : @"a name",
                                                      @"details" : @"a description"}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[section should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[section should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[section.identifier should] equal:@"1"];
        });
        
        it(@"has created at attribute", ^{
            [[section.createdAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has updated at attribute", ^{
            [[section.updatedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has name attribute", ^{
            [[section.name should] equal:@"a name"];
        });
        
        it(@"has details attribute", ^{
            [[section.details should] equal:@"a description"];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
        });
    });
    
    context(@"mapping", ^{
        
    });
});

SPEC_END