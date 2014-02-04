//
//  AMCompanyTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <objc/message.h>
#import <Kiwi/Kiwi.h>
#import "AMCompany.h"

SPEC_BEGIN(AMCompanyTests)

describe(@"AMCompany", ^{
    context(@"object", ^{
        
        __block AMCompany *company;
        
        beforeAll(^{
            company = [[AMCompany alloc] init];
        });
        
        it(@"subclasses MTLModel", ^{
            [[company should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[company should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        //    it(@"has identifier", ^{
        //        [[company.identifier should] beKindOfClass:[NSString class]];
        //    });
        //
        //    it(@"has name", ^{
        //        [[company.name should] beKindOfClass:[NSString class]];
        //    });
        //
        //    it(@"has address", ^{
        //        [[company.address should] beKindOfClass:[AMAddress class]];
        //    });
        //
        //    it(@"has website", ^{
        //        [[company.website should] beKindOfClass:[NSURL class]];
        //    });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from +JSONKeyPathsByPropertyKey",^{
            NSDictionary *mapping = [AMCompany JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"createdAt" : @"createdAt",
                                              @"updatedAt" : @"updatedAt",
                                              @"name" : @"name",
                                              @"address" : @"address",
                                              @"website" : @"website"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements addressJSONTransformer", ^{
            [[AMCompany should] respondToSelector:NSSelectorFromString(@"addressJSONTransfomer")];
        });
        
        it(@"returns AMAddress transformer from addressJSONTransfomer", ^{
            NSValueTransformer *valueTransfomer = objc_msgSend([AMCompany class], NSSelectorFromString(@"addressJSONTransfomer"));
            [[valueTransfomer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures address can be transformed with this transformer
        });
        
        it(@"implements createdAtJSONTransformer", ^{
            [[AMCompany should] respondToSelector:NSSelectorFromString(@"createdAtJSONTransformer")];
        });
        
        it(@"returns NSDate value transformer from createdAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMCompany class], NSSelectorFromString(@"createdAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures date can be transformed with this transformer
        });
        
        it(@"implements updatedAtJSONTransformer", ^{
            [[AMCompany should] respondToSelector:NSSelectorFromString(@"updatedAtJSONTransformer")];
        });
        
        it(@"returns NSDate value transformer from updatedAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMCompany class], NSSelectorFromString(@"updatedAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
            // TODO (Robert Lis): Write test that ensures date can be transformed with this transformer
        });
    });
});

SPEC_END
