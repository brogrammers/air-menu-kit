//
//  AMClientCreditCardTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#include <Kiwi/Kiwi.h>
#include "TestToolBox.h"
#include "AMClient+CreditCard.h"

SPEC_BEGIN(AMClientCreditCardTest)
describe(@"AMClient+AMCreditCard", ^{
    context(@"on error free flow", ^{
        
        context(@"on find credit card", ^{
            __block NSURLSessionDataTask *task;
            __block AMCreditCard *card;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"credit_cards/1"]
                                     httpMethod:@"GET"
                             nameOfResponseFile:@"credit_card.json"
                                   responseCode:200];
                
                task = [[AMClient sharedClient] findCreditCardWithIdentifier:@"1" completion:^(AMCreditCard *creditCard, NSError *error) {
                    card = creditCard;
                }];
            });
            
            it(@"uses GET method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"GET"];
            });
            
            it(@"calls /credit_cards/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"credit_cards/1"]];
            });
            
            it(@"creates credt card object", ^{
                [[expectFutureValue(card) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"credit_card.json"]];
            });
        });
        
        context(@"on update credit card", ^{
            __block NSURLSessionDataTask *task;
            __block AMCreditCard *card;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"credit_cards/1"]
                                     httpMethod:@"PUT"
                             nameOfResponseFile:@"credit_card.json"
                                   responseCode:200];
                
                AMCreditCard *creditCard = [[AMCreditCard alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] updateCreditCard:creditCard
                                            withNewNumber:@"12345"
                                              newCardType:@"AMERICAN_EXPRESS"
                                           newExpiryMonth:@"12"
                                            newExpiryYear:@"2012"
                                                   newCVC:@"299"
                                               completion:^(AMCreditCard *creditCard, NSError *error) {
                                                   card = creditCard;
                                               }];
            });
            
            it(@"uses PUT method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"PUT"];
            });
            
            it(@"calls /credit_cards/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"credit_cards/1"]];
            });
            
            it(@"creates credt card object", ^{
                [[expectFutureValue(card) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"credit_card.json"]];
            });
            
            
            it(@"sends paramters in HTTP body", ^{
                [[[TestToolBox bodyOfRequest:task.originalRequest] should] equal:@{@"number" : @"12345",
                                                                                   @"card_type" : @"AMERICAN_EXPRESS",
                                                                                   @"month" : @"12",
                                                                                   @"year" : @"2012",
                                                                                   @"cvc" : @"299"}];
            });
        });
        
        context(@"on delete credit card", ^{
            __block NSURLSessionDataTask *task;
            __block AMCreditCard *card;
            
            beforeAll(^{
                [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"credit_cards/1"]
                                     httpMethod:@"DELETE"
                             nameOfResponseFile:@"credit_card.json"
                                   responseCode:200];
                
                AMCreditCard *creditCard = [[AMCreditCard alloc] initWithDictionary:@{@"identifier" : @(1)} error:nil];
                task = [[AMClient sharedClient] deleteCreditCard:creditCard completion:^(AMCreditCard *creditCard, NSError *error) {
                    card = creditCard;
                }];
            });
            
            it(@"uses DELETE method", ^{
                [[task.originalRequest.HTTPMethod should] equal:@"DELETE"];
            });
            
            it(@"calls /credit_cards/1", ^{
                [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"credit_cards/1"]];
            });
            
            it(@"creates credt card object", ^{
                [[expectFutureValue(card) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"credit_card.json"]];
            });
        });
    });
});
SPEC_END