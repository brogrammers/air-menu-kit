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
-(NSURLSessionDataTask *)findCreditCardWithIdentifier:(NSString *)identifier
                                           completion:(CreditCardCompletion)completion;

-(NSURLSessionDataTask *)updateCreditCard:(AMCreditCard *)creditCard
                            withNewNumber:(NSString *)number
                              newCardType:(NSString *)type
                           newExpiryMonth:(NSString *)month
                            newExpiryYear:(NSString *)year
                                   newCVC:(NSString *)cvc
                               completion:(CreditCardCompletion)completion;

-(NSURLSessionDataTask *)deleteCreditCard:(AMCreditCard *)card
                               completion:(CreditCardCompletion)completion;

@end
