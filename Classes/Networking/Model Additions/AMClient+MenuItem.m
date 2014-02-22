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

@end
