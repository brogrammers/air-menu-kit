//
//  AMObjectBuilder.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMObjectBuilder : NSObject
+(instancetype)sharedInstance;
-(id)objectFromJSON:(NSDictionary *)json;
@end