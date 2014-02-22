//
//  AMClient+Menu.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+Menu.h"
#import "AMObjectBuilder.h"

@implementation AMClient (Menu)
-(NSURLSessionDataTask *)findMenuWithIdentifier:(NSString *)identifier
                                     completion:(MenuCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"menus/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMMenu *menu = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(menu,nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)createSectionOfMenu:(AMMenu *)menu
                                    withName:(NSString *)name
                                 description:(NSString *)description
                                  completion:(MenuSectionCompletion)completion
{
    NSAssert(menu.identifier, @"menus identifier cannot be nil");
    NSString *urlString = [@"menus/" stringByAppendingFormat:@"%@/%@", menu.identifier, @"menu_sections"];
    return [self POST:urlString
           parameters:@{@"name" : name, @"description" : description }
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMMenuSection *menuSection = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(menuSection, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}

-(NSURLSessionDataTask *)findSectionsOfMenu:(AMMenu *)menu
                                 completion:(MenuSectionsCompletion)completion
{
    NSAssert(menu.identifier, @"menus identifier cannot be nil");
    NSString *urlString = [@"menus/" stringByAppendingFormat:@"%@/%@", menu.identifier, @"menu_sections"];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *menuSections = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(menuSections, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}
@end
