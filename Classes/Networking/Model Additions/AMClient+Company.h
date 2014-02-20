//
//  AMClient+Company.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMCompany.h"
#import "AMRestaurant.h"

typedef void (^CompanyCompletion) (AMCompany *company, NSError *error);
typedef void (^CompanyRestaurantCompletion) (AMRestaurant *restaurant, NSError *error);
typedef void (^CompanyRestaurantsCompletion) (NSArray *restaurants, NSError *error);

@interface AMClient (Company)

-(NSURLSessionDataTask *)createCompanyWithName:(NSString *)name
                                       website:(NSString *)website
                                addressLineOne:(NSString *)lineOne
                                addresslineTwo:(NSString *)lineTwo
                                          city:(NSString *)city
                                        county:(NSString *)county
                                         state:(NSString *)state
                                       country:(NSString *)country
                                    completion:(CompanyCompletion)completion;

-(NSURLSessionDataTask *)findCompanyWithIdentifier:(NSString *)identifier
                                        completion:(CompanyCompletion)completion;

-(NSURLSessionDataTask *)createRestaurantOfCompany:(AMCompany *)company
                                          withName:(NSString *)name
                                           loyalty:(BOOL)loyalty
                                       remoteOrder:(BOOL)remoteOrder
                                    conversionRate:(NSNumber *)rate
                                    addressLineOne:(NSString *)lineOne
                                    addressLineTwo:(NSString *)lineTwo
                                              city:(NSString *)city
                                            county:(NSString *)county
                                             state:(NSString *)state
                                           country:(NSString *)country
                                        completion:(CompanyRestaurantCompletion)completion;

-(NSURLSessionDataTask *)findRestaurantsOfCompany:(AMCompany *)company
                                       completion:(CompanyRestaurantsCompletion)completion;
@end
