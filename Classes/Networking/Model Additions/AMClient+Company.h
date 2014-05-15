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

/**
 *  Company completion block
 *
 *  @param company company fetched
 *  @param error   error that occured
 */
typedef void (^CompanyCompletion) (AMCompany *company, NSError *error);

/**
 *  Restaurant completion block
 *
 *  @param restaurant restaurant fetched
 *  @param error      error that occured
 */
typedef void (^CompanyRestaurantCompletion) (AMRestaurant *restaurant, NSError *error);

/**
 *  Restaurants completion block
 *
 *  @param restaurants array of restaurants fetched
 *  @param error       error that occured
 */
typedef void (^CompanyRestaurantsCompletion) (NSArray *restaurants, NSError *error);

@interface AMClient (Company)

/**
 *  GET /companies
 *
 *  @param identifier identifier of the company - required
 *  @param completion completion block
 *
 *  @return task spawed by the method
 */
-(NSURLSessionDataTask *)findCompanyWithIdentifier:(NSString *)identifier
                                        completion:(CompanyCompletion)completion;

/**
 *  POST /companies
 *
 *  @param name       name of the new company - required
 *  @param website    website of the new company - required
 *  @param lineOne    first address line of a new company - required
 *  @param lineTwo    second address line of a new company - required
 *  @param city       city of a new company - required
 *  @param county     county of a new company - required
 *  @param state      state of a new company - optional
 *  @param country    country of a new company - required
 *  @param completion completion block
 *
 *  @return task spawned by the method
 */
-(NSURLSessionDataTask *)createCompanyWithName:(NSString *)name
                                       website:(NSString *)website
                                addressLineOne:(NSString *)lineOne
                                addresslineTwo:(NSString *)lineTwo
                                          city:(NSString *)city
                                        county:(NSString *)county
                                         state:(NSString *)state
                                       country:(NSString *)country
                                    completion:(CompanyCompletion)completion;
/**
 *  PUT /companies
 *
 *  @param company    company to be updated - required
 *  @param name       new name - optional
 *  @param website    new website - optional
 *  @param lineOne    new address line one - optional
 *  @param lineTwo    new address line two - optional
 *  @param city       new city - optional
 *  @param county     new county - optional
 *  @param state      new state - optional
 *  @param country    new county - optional
 *  @param completion competion block
 *
 *  @return task spawned by the method
 */
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

/**
 *  DELETE /companies
 *
 *  @param company    company to be deleted - required
 *  @param completion completion block
 *
 *  @return task spawned by the method
 */
-(NSURLSessionDataTask *)deleteCompany:(AMCompany *)company
                            completion:(CompanyCompletion)completion;

/*
 Restaurants of company
 */

/**
 *  GET /companies/:id/restaurants
 *
 *  @param company    company of restaurants - required
 *  @param completion completion block
 *
 *  @return task spawned by the method
 */
-(NSURLSessionDataTask *)findRestaurantsOfCompany:(AMCompany *)company
                                       completion:(CompanyRestaurantsCompletion)completion;


-(NSURLSessionDataTask *)createRestaurantOfCompany:(AMCompany *)company
                                          category:(NSString *)category
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
