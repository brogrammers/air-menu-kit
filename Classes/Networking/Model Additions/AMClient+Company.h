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

-(NSURLSessionDataTask *)updateCompany:(AMCompany *)company
                           withNewName:(NSString *)name
                            newWebsite:(NSString *)website
                     newAddressLineOne:(NSString *)lineOne
                     newAddressLineTwo:(NSString *)lineTwo
                               newCity:(NSString *)city
                             newCounty:(NSString *)county
                              newState:(NSString *)state
                            newCountry:(NSString *)country
                            completion:(CompanyCompletion)completion;

-(NSURLSessionDataTask *)deleteCompany:(AMCompany *)company
                            completion:(CompanyCompletion)completion;

/*
 Restaurants of company
 */

-(NSURLSessionDataTask *)findRestaurantsOfCompany:(AMCompany *)company
                                       completion:(CompanyRestaurantsCompletion)completion;

-(NSURLSessionDataTask *)createRestaurantOfCompany:(AMCompany *)company
                                       description:(NSString *)description
                                          withName:(NSString *)name
                                    addressLineOne:(NSString *)lineOne
                                    addressLineTwo:(NSString *)lineTwo
                                              city:(NSString *)city
                                            county:(NSString *)county
                                             state:(NSString *)state
                                           country:(NSString *)country
                                          latitude:(double)latitude
                                         longitude:(double)longitude
                                             image:(UIImage *)image
                                        completion:(CompanyRestaurantCompletion)completion;

@end
