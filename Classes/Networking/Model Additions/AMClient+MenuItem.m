//
//  AMClient+MenuItem.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+MenuItem.h"
#import "AMObjectBuilder.h"

@implementation AMClient (MenuItem)

-(NSURLSessionDataTask *)findMenuItemWithIdentifier:(NSString *)identifier
                                         completion:(MenuItemCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"menu_items/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMMenuItem *item = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(item, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateMenuItem:(AMMenuItem *)item
                            withNewName:(NSString *)name
                         newDescription:(NSString *)description
                               newPrice:(NSNumber *)price
                            newCurrency:(NSString *)currency
                         newStaffKindId:(NSString *)staffKindIdentifier
                             completion:(MenuItemCompletion)completion
{
    NSAssert(item.identifier, @"item dentifier cannot be nil");
    NSString *urlString = [@"menu_items/" stringByAppendingString:item.identifier.description];
    NSDictionary *params = @{@"name" : name, @"description" : description, @"price" : price, @"currency" : currency, @"staff_kind_id" : staffKindIdentifier};
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMMenuItem *item = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(item, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)deleteMenuItem:(AMMenuItem *)menuItem
                             completion:(MenuItemCompletion)completion
{
    NSAssert(menuItem.identifier, @"item identifier cannot be nil");
    NSString *urlString = [@"menu_items/" stringByAppendingString:menuItem.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMMenuItem *item = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(item, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

@end
