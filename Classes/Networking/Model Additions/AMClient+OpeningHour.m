//
//  AMClient+OpeningHours.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+OpeningHour.h"
#import "AMObjectBuilder.h"
#import "NSDateFormatter+AirMenuTimestamp.h"

@implementation AMClient (OpeningHour)

-(NSURLSessionDataTask *)findOpeningHourWithIdentifier:(NSString *)identifier
                                            completion:(OpeningHourCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"opening_hours/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMOpeningHour *openingHour = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(openingHour, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateOpeningHour:(AMOpeningHour *)openingHour
                                    newDay:(NSString *)day
                                  newStart:(NSDate *)start
                                    newEnd:(NSDate *)end
                                completion:(OpeningHourCompletion)completion
{
    NSAssert(openingHour.identifier, @"hour's identifier cannot be nil");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(day) [params setObject:day forKey:@"day"];
    if(start) [params setObject:[[NSDateFormatter sharedAirMenuFormatter] stringFromDate:start] forKey:@"start"];
    if(end) [params setObject:[[NSDateFormatter sharedAirMenuFormatter] stringFromDate:end] forKey:@"end"];
    NSString *urlString = [@"opening_hours/" stringByAppendingString:openingHour.identifier.description];
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMOpeningHour *openingHour = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(openingHour, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)deleteOpeningHours:(AMOpeningHour *)openingHour
                                 completion:(OpeningHourCompletion)completion
{
    NSString *urlString = [@"opening_hours/" stringByAppendingString:openingHour.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMOpeningHour *openingHour = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(openingHour, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}
@end
