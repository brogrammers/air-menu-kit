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
    
    NSAssert(name, @"name must cannot be nil");
    NSAssert(website, @"website must cannot be nil");
    NSAssert(lineOne, @"line one must cannot be nil");
    NSAssert(lineTwo, @"line two must cannot be nil");
    NSAssert(city, @"city must cannot be nil");
    NSAssert(county, @"county must cannot be nil");
    NSAssert(country, @"country must cannot be nil");
    
    NSMutableDictionary *params = [@{@"name" : name,
                                    @"website" : website,
                                    @"address_1" : lineOne,
                                    @"address_2" : lineTwo,
                                    @"city" : city,
                                    @"county" : county,
                                    @"country" : country} mutableCopy];
    if (state) [params setObject:state forKey:@"state"];
    
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


-(NSURLSessionDataTask *)updateCompany:(AMCompany *)company
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
    NSAssert(company.identifier, @"company object must have a identifier present");
    NSString *urlString = [NSString stringWithFormat:@"companies/%@", company.identifier.description];
    NSMutableDictionary *params = [@{} mutableCopy];
    if(name)[params setObject:name forKey:@"name"];
    if(website) [params setObject:website forKey:@"website"];
    if(lineOne) [params setObject:lineOne forKey:@"address_1"];
    if(lineTwo) [params setObject:lineTwo forKey:@"address_2"];
    if(city) [params setObject:city forKey:@"city"];
    if(country) [params setObject:country forKey:@"country"];
    if(state) [params setObject:state forKey:@"state"];
    if(county) [params setObject:county forKey:@"county"];
    
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


-(NSURLSessionDataTask *)deleteCompany:(AMCompany *)company
                            completion:(CompanyCompletion)completion
{
    NSAssert(company.identifier, @"company object must have a identifier present");
    NSString *urlString = [NSString stringWithFormat:@"companies/%@", company.identifier.description];
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

/*
 Restaurants of company
 */

-(NSURLSessionDataTask *)findRestaurantsOfCompany:(AMCompany *)company
                                       completion:(CompanyRestaurantsCompletion)completion
{
    NSAssert(company.identifier, @"company object must have a identifier present");
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
                                        completion:(CompanyRestaurantCompletion)completion
{
    NSAssert(company.identifier, @"the company object must have a identifier present");
    NSString *urlString = [NSString stringWithFormat:@"companies/%@/restaurants", company.identifier];
    NSMutableDictionary *parameters = [@{@"name" : name,
                                        @"description" : description,
                                        @"address_1" : lineOne,
                                        @"address_2" : lineTwo,
                                        @"city" : city,
                                        @"county" : county,
                                        @"country" : country,
                                        @"latitude" : @(latitude),
                                        @"longitude" : @(longitude)} mutableCopy];
    if(state) [parameters setObject:state forKey:@"state"];
    
    
    if(image)
    {
        return [self POST:urlString
               parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    if(image)
                    {
                        [formData appendPartWithFormData:UIImagePNGRepresentation(image) name:@"avatar"];
                    }
                }
                success:^(NSURLSessionDataTask *task, id responseObject) {
                      AMRestaurant *restaurant = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                      if(completion) completion(restaurant, nil);
                }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      if(completion) completion(nil, error);
                }];
        
    }
    else
    {
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
}

@end
