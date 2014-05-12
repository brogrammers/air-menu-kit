//
//  AMOpeningHourTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/objc-runtime.h>
#import "AMOpeningHour.h"


SPEC_BEGIN(AMOpeningHourTests)
describe(@"AMOpeningHour", ^{
    
    context(@"object", ^{
        __block AMOpeningHour *openingHour;
        
        beforeAll(^{
            openingHour = [AMOpeningHour new];
            [openingHour setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                          @"day" : @"monday",
                                                          @"startTime" : [NSDate dateWithTimeIntervalSince1970:1],
                                                          @"endTime" : [NSDate dateWithTimeIntervalSince1970:1]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[openingHour should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms MTLJSONSerializing protocol", ^{
            [[openingHour should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[openingHour.identifier should] equal:@(1)];
        });
        
        it(@"has day attribute", ^{
            [[openingHour.day should] equal:@"monday"];
        });
        
        it(@"has startTime attribute", ^{
            [[openingHour.startTime should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has endTime attribute", ^{
            [[openingHour.endTime should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMOpeningHour JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"day" : @"day",
                                              @"startTime" : @"start",
                                              @"endTime" : @"end"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"responds to startTimeJSONTransformer", ^{
            [[[AMOpeningHour class] should] respondToSelector:NSSelectorFromString(@"startTimeJSONTransformer")];
        });
        
        it(@"retrns user dicionary transformer from userJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMOpeningHour class], NSSelectorFromString(@"startTimeJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
        it(@"responds to endTimeJSONTransformer", ^{
            [[[AMOpeningHour class] should] respondToSelector:NSSelectorFromString(@"endTimeJSONTransformer")];
        });
        
        it(@"retrns user dicionary transformer from userJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMOpeningHour class], NSSelectorFromString(@"endTimeJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        __block NSDictionary *openingHourJSON;
        __block AMOpeningHour *openingHour;
        
        beforeAll(^{
            openingHourJSON = @{@"id" : @(1),
                                @"start" : @"2000-01-01T09:00:00Z",
                                @"end" : @"2000-01-01T09:00:00Z",
                                @"day" : @"sunday"};
            openingHour = [MTLJSONAdapter modelOfClass:[AMOpeningHour class] fromJSONDictionary:openingHourJSON error:nil];
        });
        
        
        it(@"correctly parses and maps opening hour object", ^{
            [[openingHour.identifier should] equal:@(1)];
            [[openingHour.startTime shouldNot] beNil];
            [[openingHour.endTime shouldNot] beNil];
            [[openingHour.day should] equal:@"sunday"];
        });
    });
});
SPEC_END