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

-(NSURLSessionDataTask *)findOpeningHourWithIdentifier:(NSString *)identifier
                                             completion:(OpeningHourCompletion)completion;

-(NSURLSessionDataTask *)updateOpeningHour:(AMOpeningHour *)openingHours
                                    newDay:(NSString *)day
                                  newStart:(NSDate *)start
                                    newEnd:(NSDate *)end
                                completion:(OpeningHourCompletion)completion;

-(NSURLSessionDataTask *)deleteOpeningHours:(AMOpeningHour *)openingHour
                                 completion:(OpeningHourCompletion)completion;
@end
