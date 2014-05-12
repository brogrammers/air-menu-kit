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

-(NSURLSessionDataTask *)deleteMenu:(AMMenu *)menu completion:(MenuCompletion)completion
{
    NSAssert(menu.identifier, @"menu identifier cannot be nil");
    NSString *urlString = [@"menus/" stringByAppendingString:menu.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMMenu *menu = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(menu,nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

-(NSURLSessionDataTask *)updateMenu:(AMMenu *)menu newActive:(BOOL)isActive newName:(NSString *)name completion:(MenuCompletion)completion;{
    NSAssert(menu.identifier, @"menu identifier cannot be nil");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:isActive ? @"true" : @"false" forKey:@"active"];
    if(name) [params setObject:name forKey:@"name"];
    
    NSString *urlString = [@"menus/" stringByAppendingString:menu.identifier.description];
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMMenu *menu = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(menu,nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);

             }];
}

/*
 Menu > Menu Sections
 */

-(NSURLSessionDataTask *)createSectionOfMenu:(AMMenu *)menu
                                    withName:(NSString *)name
                                 description:(NSString *)description
                                 staffKindId:(NSString *)staffKindIdentifier
                                  completion:(MenuSectionCompletion)completion
{
    NSAssert(menu.identifier, @"menus identifier cannot be nil");
    NSAssert(name, @"name cannot be nil");
    NSAssert(name, @"description cannot be nil");
    NSAssert(name, @"staff kind id cannot be nil");
    
    NSString *urlString = [@"menus/" stringByAppendingFormat:@"%@/%@", menu.identifier, @"menu_sections"];
    return [self POST:urlString
           parameters:@{@"name" : name, @"description" : description, @"staff_kind_id" : staffKindIdentifier }
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
