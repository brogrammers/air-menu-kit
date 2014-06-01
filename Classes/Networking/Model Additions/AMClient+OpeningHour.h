//
//  AMClient+OpeningHours.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMOpeningHour.h"

typedef void (^OpeningHourCompletion) (AMOpeningHour *openingHour, NSError *error);


@interface AMClient (OpeningHour)
/**
 *  GET /opening_hours/:id
 *
 *  @param identifier identifier of opening hours - identifier
 *  @param completion block executed upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)findOpeningHourWithIdentifier:(NSString *)identifier
                                            completion:(OpeningHourCompletion)completion;

/**
 *  PUT /opening_hours/:id
 *
 *  @param openingHours opening hours to update
 *  @param day          new day of concern
 *  @param start        new opening time
 *  @param end          new closing time
 *  @param completion   block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)updateOpeningHour:(AMOpeningHour *)openingHours
                                    newDay:(NSString *)day
                                  newStart:(NSDate *)start
                                    newEnd:(NSDate *)end
                                completion:(OpeningHourCompletion)completion;

/**
 *  DELETE /opening_hours/:id
 *
 *  @param openingHour opening hour to delete
 *  @param completion  block to execute upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)deleteOpeningHours:(AMOpeningHour *)openingHour
                                 completion:(OpeningHourCompletion)completion;
@end
