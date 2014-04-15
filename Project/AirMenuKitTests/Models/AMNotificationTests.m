//
//  AMNotificationTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMNotification.h"
#import <objc/objc-runtime.h>
#import "NSDateFormatter+AirMenuTimestamp.h"

SPEC_BEGIN(AMNotificationTests)
describe(@"AMNotification", ^{
    context(@"class", ^{
        __block AMNotification *notification;
        
        beforeAll(^{
            notification = [AMNotification new];
            [notification setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                           @"content" : @"a content",
                                                           @"read" : @YES,
                                                           @"payload" : @"some payload",
                                                           @"createdAt" :[NSDate dateWithTimeIntervalSince1970:1]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[notification should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms MTLJSONSerializing protocol", ^{
            [[notification should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[notification.identifier should] equal:@1];
        });
        
        it(@"has content attribute", ^{
            [[notification.content should] equal:@"a content"];
        });
        
        it(@"has read attribute", ^{
            [[notification.read should] equal:@YES];
        });
        
        it(@"has payload attribute", ^{
            [[notification.payload should] equal:@"some payload"];
        });
        
        it(@"has created at attribute", ^{
            [[notification.createdAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
    });
    
    context(@"object", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMNotification JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"content" : @"content",
                                              @"read" : @"read",
                                              @"payload" : @"payload",
                                              @"createdAt" : @"created_at"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements createdAtJSONTransformer", ^{
            [[[AMNotification class] should] respondToSelector:NSSelectorFromString(@"createdAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from createdAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMNotification class], NSSelectorFromString(@"createdAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        __block AMNotification *notification;
        __block NSDictionary *parsedNotificationJSON;
        
        beforeAll(^{
            parsedNotificationJSON = @{@"id": @2,
                                       @"content": @"Some Other Notification",
                                       @"read": @(YES),
                                       @"payload": @"",
                                       @"created_at": @"2014-04-12T23:30:26Z"};
            notification = [MTLJSONAdapter modelOfClass:[AMNotification class] fromJSONDictionary:parsedNotificationJSON error:nil];
        });
        
        it(@"maps notification JSON to AMNotification object", ^{
            [[notification.identifier should] equal:@2];
            [[notification.content should] equal:@"Some Other Notification"];
            [[notification.read should] equal:@(YES)];
            [[notification.payload should] equal:@""];
            [[notification.createdAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2014-04-12T23:30:26Z"]];
        });
    });
});
SPEC_END

