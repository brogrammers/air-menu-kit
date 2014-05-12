//
//  AMReviewTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/objc-runtime.h>
#import "AMReview.h"

SPEC_BEGIN(AMReviewTests)
describe(@"AMReview", ^{
    
    context(@"object", ^{
        __block AMReview *review;
        
        beforeAll(^{
            review = [AMReview new];
            [review setValuesForKeysWithDictionary:@{@"identifier" : @1,
                                                     @"subject" : @"sub",
                                                     @"message" : @"msg",
                                                     @"rating" : @(4),
                                                     @"user" :[AMUser new]}];
        });
        
        it(@"subclasses MTLModel", ^{
            [[review should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms MTLJSONSerializing protocol", ^{
            [[review should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attibute", ^{
            [[review.identifier should] equal:@(1)];
        });
        
        it(@"has subject attribute", ^{
            [[review.subject should] equal:@"sub"];
        });
        
        it(@"has message attribute", ^{
            [[review.message should] equal:@"msg"];
        });
        
        it(@"has raiting attribute", ^{
            [[review.rating should] equal:@(4)];
        });
        
        it(@"has user attribute", ^{
            [[review.user should] equal:[AMUser new]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMReview JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"subject" : @"subject",
                                              @"message" : @"message",
                                              @"rating" : @"rating",
                                              @"user" : @"user"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"responds to userJSONTransformer", ^{
            [[[AMReview class] should] respondToSelector:NSSelectorFromString(@"userJSONTransformer")];
        });
        
        it(@"retrns user dicionary transformer from userJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMReview class], NSSelectorFromString(@"userJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        __block NSDictionary *reviewJSON;
        __block NSDictionary *userJSON;
        __block AMReview *review;
        
        beforeAll(^{
            userJSON = @{@"id" : @(1)};
            reviewJSON = @{@"id" : @(5),
                           @"subject" : @"sub",
                           @"message" : @"msg",
                           @"rating" : @(5),
                           @"user" : userJSON};
            
            review = [MTLJSONAdapter modelOfClass:[AMReview class] fromJSONDictionary:reviewJSON error:nil];
        });
        
        it(@"correctly parses and maps review object", ^{
            [[review.identifier should] equal:@(5)];
            [[review.subject should] equal:@"sub"];
            [[review.message should] equal:@"msg"];
            [[review.rating should] equal:@(5)];
        });
        
        it(@"correctly parses and hooks up user object", ^{
            [[review.user.identifier should] equal:@(1)];
        });
    });
});
SPEC_END