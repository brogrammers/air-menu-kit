//
//  AMLocation.h
//  AirMenuKit
//
//  Created by Robert Lis on 15/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMLocation.h"
#define kVerySmallValue (0.00000000001)

@implementation AMLocation
-(BOOL)isEqual:(CLLocation *)object
{
    return  object.class == self.class &&
    [self firstDouble:[self distanceFromLocation:object] isEqualTo:0];
}

- (BOOL)firstDouble:(double)first isEqualTo:(double)second
{
    if(fabsf(first - second) < kVerySmallValue)
        return YES;
    else
        return NO;
}

- (NSUInteger) hash
{
    NSUInteger theHash = (NSUInteger) (self.coordinate.latitude * 360 + self.coordinate.longitude);
    return theHash;
}
@end
