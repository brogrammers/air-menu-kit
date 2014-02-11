//
//  NSNumberFormatter+AirMenuNumberFormat.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "NSNumberFormatter+AirMenuNumberFormat.h"

@implementation NSNumberFormatter (AirMenuNumberFormat)
+(NSNumberFormatter *)sharedAirMenuFormatter
{
    static NSNumberFormatter *_sharedFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFormatter = [[NSNumberFormatter alloc] init];
        _sharedFormatter.locale = [NSLocale currentLocale];
        _sharedFormatter.formatterBehavior = NSNumberFormatterBehavior10_4;
        _sharedFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    });
    
    return _sharedFormatter;
}
@end
