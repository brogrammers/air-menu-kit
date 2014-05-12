//
//  AMClient+CreditCard.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+CreditCard.h"
#import "AMObjectBuilder.h"

@implementation AMClient (CreditCard)
-(NSURLSessionDataTask *)findCreditCardWithIdentifier:(NSString *)identifier
                                           completion:(CreditCardCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"credit_cards/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMCreditCard *creditCard = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(creditCard, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateCreditCard:(AMCreditCard *)creditCard
                            withNewNumber:(NSString *)number
                              newCardType:(NSString *)type
                           newExpiryMonth:(NSString *)month
                            newExpiryYear:(NSString *)year
                                   newCVC:(NSString *)cvc
                               completion:(CreditCardCompletion)completion
{
    NSAssert(creditCard.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"credit_cards/" stringByAppendingString:creditCard.identifier.description];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(number) [params setObject:number forKey:@"number"];
    if(type) [params setObject:type forKey:@"card_type"];
    if(month) [params setObject:month forKey:@"month"];
    if(year) [params setObject:year forKey:@"year"];
    if(cvc) [params setObject:cvc forKey:@"cvc"];
    
    return [self  PUT:urlString
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMCreditCard *creditCard = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(creditCard, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)deleteCreditCard:(AMCreditCard *)card
                               completion:(CreditCardCompletion)completion;
{
    NSAssert(card.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"credit_cards/" stringByAppendingString:card.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMCreditCard *creditCard = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(creditCard, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}
@end
