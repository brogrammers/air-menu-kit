//
//  AMDeviceTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 13/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMDevice.h"


SPEC_BEGIN(AMDeviceTests)
describe(@"AMDevice", ^{
    
    context(@"object", ^{
        __block AMDevice *device;
        
        beforeAll(^{
            device = [AMDevice new];
            [device setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                     @"name" : @"a name",
                                                     @"uuid" : @"12345",
                                                     @"token" : @"12345",
                                                     @"platform" : @"ios"}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[device should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[device should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"should have identifier attribute", ^{
            [[device.identifier should] equal:@1];
        });
        
        it(@"has name attribute", ^{
            [[device.name should] equal:@"a name"];
        });
        
        it(@"has uuid attribute", ^{
            [[device.uuid should] equal:@"12345"];
        });
        
        it(@"has token attribute", ^{
            [[device.token should] equal:@"12345"];
        });
        
        it(@"has platform attribute", ^{
            [[device.platform should] equal:@"ios"];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMDevice JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"uuid" : @"uuid",
                                              @"token" : @"token",
                                              @"platform" : @"platform"};
            [[mapping should] equal:expectedMapping];
        });
    });
    
    context(@"mapping", ^{
        __block AMDevice *device;
        __block NSDictionary *parsedDeviceDicionary;
        
        beforeAll(^{
            parsedDeviceDicionary = @{@"id": @1,
                                      @"name": @"First Phone",
                                      @"uuid": @"some_uuid",
                                      @"token": @"some_token",
                                      @"platform": @"ios"};
            device = [MTLJSONAdapter modelOfClass:[AMDevice class] fromJSONDictionary:parsedDeviceDicionary error:nil];
        });
        
        
        it(@"maps parsed device JSON to AMDevice object", ^{
            [[device.identifier should] equal:@1];
            [[device.name should] equal:@"First Phone"];
            [[device.uuid should] equal:@"some_uuid"];
            [[device.token should] equal:@"some_token"];
            [[device.platform should] equal:@"ios"];
        });
    });
});
SPEC_END