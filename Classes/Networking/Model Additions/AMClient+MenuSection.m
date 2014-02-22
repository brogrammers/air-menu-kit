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

-(NSURLSessionDataTask *)createItemOfSection:(AMMenuSection *)section
                                    withName:(NSString *)name
                                 description:(NSString *)description
                                       price:(NSNumber *)price
                                    currency:(NSString *)currency
                                  completion:(MenuSectionItemCompletion)completion
{
    NSAssert(section.identifier, @"sections identifier cannot be nil");
    NSString *urlString = [@"menu_sections/" stringByAppendingFormat:@"%@/%@", section.identifier, @"menu_items"];
    return [self POST:urlString
           parameters:@{@"name" : name, @"description" : description, @"price" : price, @"currency" : currency}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMMenuItem *menuItem = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(menuItem, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
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
