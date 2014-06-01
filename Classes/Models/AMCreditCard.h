//
//  AMCreditCard.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>


/**
 *  AMCredit card represents a registered credit card that user can make payments with.
 */
@interface AMCreditCard : MTLModel <MTLJSONSerializing>

/**
 *  Unique identifier.
 */
@property (nonatomic, readwrite, strong) NSNumber *identifier;

/**
 *  Type of the card. VISA, AMERICAN EXPRESS.
 */
@property (nonatomic, readwrite, strong) NSString *cardType;

/**
 *  Exipiry month of the card.
 */
@property (nonatomic, readwrite, strong) NSString *expiryMonth;

/**
 *  Expiry year of the card.
 */
@property (nonatomic, readwrite, strong) NSString *expiryYear;

/**
 *  Credit card number with *'s.
 */
@property (nonatomic, readwrite, strong) NSString *number;

/**
 *  CVC code of the card.
 */
@property (nonatomic, readwrite, strong) NSString *cvc;
@end
