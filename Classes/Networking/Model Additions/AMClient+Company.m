//
//  AMClient+Company.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+Company.h"
#import "AMObjectBuilder.h"

@implementation AMClient (Company)

-(NSURLSessionDataTask *)createCompanyWithName:(NSString *)name
                                       website:(NSString *)website
                                addressLineOne:(NSString *)lineOne
                                addresslineTwo:(NSString *)lineTwo
                                          city:(NSString *)city
                                        county:(NSString *)county
                                         state:(NSString *)state
                                       country:(NSString *)country
                                    completion:(CompanyCompletion)completion
{
    NSDictionary *params = @{@"name" : name,
                             @"website" : website,
                             @"address_1" : lineOne,
                             @"address_2" : lineTwo,
                             @"city" : city,
                             @"county" : county,
                             @"state" : state,
                             @"country" : country};
    return [self POST:@"companies"
           parameters:params
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMCompany *company = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(company, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)findCompanyWithIdentifier:(NSString *)identifier
                                        completion:(CompanyCompletion)completion
{
    NSString *urlString = [NSString stringWithFormat:@"companies/%@", identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMCompany *company = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(company, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}


-(NSURLSessionDataTask *)updateCompanyWithIdentifier:(NSString *)identifier
                                         withNewName:(NSString *)name
                                          newWebsite:(NSString *)website
                                   newAddressLineOne:(NSString *)lineOne
                                   newAddressLineTwo:(NSString *)lineTwo
                                             newCity:(NSString *)city
                                           newCounty:(NSString *)county
                                            newState:(NSString *)state
                                          newCountry:(NSString *)country
                                          completion:(CompanyCompletion)completion
{
    NSString *urlString = [NSString stringWithFormat:@"companies/%@", identifier];
    NSDictionary *params = @{@"name" : name,
                             @"website" : website,
                             @"address_1" : lineOne,
                             @"address_2" : lineTwo,
                             @"city" : city,
                             @"county" : county,
                             @"state" : state,
                             @"country" : country};

    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMCompany *company = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(company, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}


-(NSURLSessionDataTask *)deleteCompanyWithIdentifier:(NSString *)identifier
                                          completion:(CompanyCompletion)completion
{
    NSString *urlString = [NSString stringWithFormat:@"companies/%@", identifier];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMCompany *company = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(company, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

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
                                        completion:(CompanyRestaurantCompletion)completion
{
    NSAssert(company.identifier, @"The company object must have a identifier present");
    NSString *urlString = [NSString stringWithFormat:@"companies/%@/restaurants", company.identifier];
    NSDictionary *parameters = @{@"name" : name,
                                 @"loyalty" : [NSNumber numberWithBool:loyalty],
                                 @"remote_order" : [NSNumber numberWithBool:remoteOrder],
                                 @"conversion_rate" : rate,
                                 @"address_1" : lineOne,
                                 @"address_2" : lineTwo,
                                 @"city" : city,
                                 @"county" : county,
                                 @"state" : state,
                                 @"country" : country,
                                 @"latitude" : @(latitude),
                                 @"longitude" : @(longitude)};
    return [self POST:urlString
           parameters:parameters
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMRestaurant *restaurant = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(restaurant, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)findRestaurantsOfCompany:(AMCompany *)company
                                       completion:(CompanyRestaurantsCompletion)completion
{
    NSAssert(company.identifier, @"The company object must have a identifier present");
    NSString *urlString = [NSString stringWithFormat:@"companies/%@/restaurants", company.identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *restaurants = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(restaurants, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}
@end
