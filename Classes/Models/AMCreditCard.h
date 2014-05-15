//
//  AMCreditCard.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface AMCreditCard : MTLModel <MTLJSONSerializing>
@property (nonatomic, readwrite, strong) NSNumber *identifier;
@property (nonatomic, readwrite, strong) NSString *cardType;
@property (nonatomic, readwrite, strong) NSString *expiryMonth;
@property (nonatomic, readwrite, strong) NSString *expiryYear;
@property (nonatomic, readwrite, strong) NSString *number;
@property (nonatomic, readwrite, strong) NSString *cvc;
@end
