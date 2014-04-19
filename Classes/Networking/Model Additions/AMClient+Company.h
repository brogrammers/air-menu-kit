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

-(NSURLSessionDataTask *)findCompanyWithIdentifier:(NSString *)identifier
                                        completion:(CompanyCompletion)completion;

-(NSURLSessionDataTask *)createCompanyWithName:(NSString *)name
                                       website:(NSString *)website
                                addressLineOne:(NSString *)lineOne
                                addresslineTwo:(NSString *)lineTwo
                                          city:(NSString *)city
                                        county:(NSString *)county
                                         state:(NSString *)state
                                       country:(NSString *)country
                                    completion:(CompanyCompletion)completion;

-(NSURLSessionDataTask *)updateCompanyWithIdentifier:(NSString *)identifier
                                         withNewName:(NSString *)name
                                          newWebsite:(NSString *)website
                                   newAddressLineOne:(NSString *)lineOne
                                   newAddressLineTwo:(NSString *)lineTwo
                                             newCity:(NSString *)city
                                           newCounty:(NSString *)county
                                            newState:(NSString *)state
                                          newCountry:(NSString *)country
                                          completion:(CompanyCompletion)completion;


-(NSURLSessionDataTask *)deleteCompanyWithIdentifier:(NSString *)identifier
                                          completion:(CompanyCompletion)completion;

/*
 Restaurants of company
 */

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
                                          latitude:(double)latitude
                                         longitude:(double)longitude
                                        completion:(CompanyRestaurantCompletion)completion;

-(NSURLSessionDataTask *)findRestaurantsOfCompany:(AMCompany *)company
                                       completion:(CompanyRestaurantsCompletion)completion;
@end
