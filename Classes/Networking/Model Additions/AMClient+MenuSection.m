//
//  AMClient+MenuSection.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+MenuSection.h"
#import "AMObjectBuilder.h"

@implementation AMClient (MenuSection)

-(NSURLSessionDataTask *)findMenuSectionWithIdentifier:(NSString *)identifier
                                            completion:(MenuSectionCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"menu_sections/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMMenuSection *section = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(section, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateMenuSection:(AMMenuSection *)section
                               withNewName:(NSString *)name
                            newDescription:(NSString *)description
                    newStaffKindIdentifier:(NSString *)identifier
                                completion:(MenuSectionCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(name) [params setObject:name forKey:@"name"];
    if(description) [params setObject:description forKey:@"description"];
    if(identifier) [params setObject:identifier forKey:@"staff_kind_id"];
    
    NSString *urlString = [@"menu_sections/" stringByAppendingString:section.identifier.description];
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMMenuSection *section = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(section, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)deleteMenuSection:(AMMenuSection *)section
                                completion:(MenuSectionCompletion)completion
{
    NSAssert(section.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"menu_sections/" stringByAppendingString:section.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMMenuSection *section = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(section, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

/*
 Menu Section > Menu Item
 */


-(NSURLSessionDataTask *)createItemOfSection:(AMMenuSection *)section
                                    withName:(NSString *)name
                                 description:(NSString *)description
                                       price:(NSNumber *)price
                                    currency:(NSString *)currency
                                 staffKindId:(NSString *)staffKindIdentifier
                                      avatar:(UIImage *)avatar
                                  completion:(MenuSectionItemCompletion)completion
{
    NSAssert(section.identifier, @"sections identifier cannot be nil");
    NSAssert(name, @"name identifier cannot be nil");
    NSAssert(price, @"price identifier cannot be nil");
    NSAssert(description, @"description identifier cannot be nil");
    NSAssert(currency, @"currency identifier cannot be nil");
    NSMutableDictionary *params = [@{@"name" : name, @"description" : description, @"price" : price, @"currency" : currency} mutableCopy];
    if(staffKindIdentifier) [params setObject:staffKindIdentifier forKey:@"staff_kind_id"];
    NSString *urlString = [@"menu_sections/" stringByAppendingFormat:@"%@/%@", section.identifier, @"menu_items"];
    if(avatar)
    {
        return [self POST:urlString
               parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                      [formData appendPartWithFormData:UIImagePNGRepresentation(avatar) name:@"avatar"];
                  }
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      AMMenuItem *menuItem = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                      if(completion) completion(menuItem, nil);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      if(completion) completion(nil, error);
                  }];
    }
    else
    {
        return [self POST:urlString
               parameters:params
                  success:^(NSURLSessionDataTask *task, id responseObject) {
                      AMMenuItem *menuItem = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                      if(completion) completion(menuItem, nil);
                  }
                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                      if(completion) completion(nil, error);
                  }];
    }
}

-(NSURLSessionDataTask *)findItemsOfSection:(AMMenuSection *)section
                                 completion:(MenuSectionItemsCompletion)completion
{
    NSAssert(section.identifier, @"sections identifier should not be nil");
    NSString *urlString = [@"menu_sections/" stringByAppendingFormat:@"%@/%@", section.identifier, @"menu_items"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *menuItems = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(menuItems, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

@end
