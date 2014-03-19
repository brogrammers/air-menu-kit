//
//  NSDictionary+NullReplacement.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "NSDictionary+NullReplacement.h"
#import "NSArray+NullReplacement.h"

@implementation NSDictionary (NullReplacement)
- (NSDictionary *)dictionaryByReplacingNullsWithBlanks
{
    const NSMutableDictionary *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    
    for (NSString *key in self)
    {
        id object = [self objectForKey:key];
        if (object == nul) [replaced removeObjectForKey:key];
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced setObject:[object dictionaryByReplacingNullsWithBlanks] forKey:key];
        else if ([object isKindOfClass:[NSArray class]]) [replaced setObject:[object arrayByReplacingNullsWithBlanks] forKey:key];
    }
    
    return [NSDictionary dictionaryWithDictionary:[replaced copy]];
}
@end
