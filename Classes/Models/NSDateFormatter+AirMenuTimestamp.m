//
//  NSDateFormatter+AirMenuTimestamp.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation NSDateFormatter (AirMenuTimestamp)
+ (NSDateFormatter *)sharedAirMenuFormatter {
    static NSDateFormatter *_sharedFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFormatter = [[NSDateFormatter alloc] init];
        _sharedFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        _sharedFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    });
    
    return _sharedFormatter;
}
@end
