//
//  NSArray+NullReplacement.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "NSArray+NullReplacement.h"
#import "NSDictionary+NullReplacement.h"

@implementation NSArray (NullReplacement)
- (NSArray *)arrayByReplacingNullsWithBlanks
{
    NSMutableArray *replaced = [self mutableCopy];
    const id nul = [NSNull null];
    
    NSUInteger count = [replaced count];
    for (int idx = 0; idx < count; idx++) {
        id object = [replaced objectAtIndex:idx];
        if (object == nul)
        {
            [replaced removeObjectAtIndex:idx];
            count--;
        }
        else if ([object isKindOfClass:[NSDictionary class]]) [replaced replaceObjectAtIndex:idx withObject:[object dictionaryByReplacingNullsWithBlanks]];
        else if ([object isKindOfClass:[NSArray class]]) [replaced replaceObjectAtIndex:idx withObject:[object arrayByReplacingNullsWithBlanks]];
    }
    return [replaced copy];
}
@end
