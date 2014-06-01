//
//  AMClient+CreditCard.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMCreditCard.h"

typedef void (^CreditCardCompletion)(AMCreditCard *creditCard, NSError *error);


@interface AMClient (CreditCard)

/**
 *  GET /credit_cards/:id
 *
 *  @param identifier identifier of the credit card - requred
 *  @param completion block exectued upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)findCreditCardWithIdentifier:(NSString *)identifier
                                           completion:(CreditCardCompletion)completion;
/**
 *  PUT /credit_cards/:id
 *
 *  @param creditCard credit card to update - required
 *  @param number     new credit card number
 *  @param type       new credit card type
 *  @param month      new credit card exipry month
 *  @param year       new credit card expiry year
 *  @param cvc        new credit card cvc
 *  @param completion new credit card completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)updateCreditCard:(AMCreditCard *)creditCard
                            withNewNumber:(NSString *)number
                              newCardType:(NSString *)type
                           newExpiryMonth:(NSString *)month
                            newExpiryYear:(NSString *)year
                                   newCVC:(NSString *)cvc
                               completion:(CreditCardCompletion)completion;

/**
 *  DELETE /credit_cards/:id
 *
 *  @param card       credit card do delete - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)deleteCreditCard:(AMCreditCard *)card
                               completion:(CreditCardCompletion)completion;

@end
