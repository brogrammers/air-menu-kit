//
//  AMLocation.h
//  AirMenuKit
//
//  Created by Robert Lis on 15/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMLocation.h"

@implementation AMLocation
-(BOOL)isEqual:(CLLocation *)object
{
    return  object.class == self.class &&
            object.coordinate.latitude == self.coordinate.latitude &&
            object.coordinate.longitude == self.coordinate.longitude;
}
@end
