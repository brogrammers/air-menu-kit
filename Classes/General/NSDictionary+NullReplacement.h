//
//  NSDictionary+NullReplacement.h
//  AirMenuKit
//
//  Created by Robert Lis on 19/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplacement)
- (NSDictionary *)dictionaryByReplacingNullsWithBlanks;
@end
