//
//  AMClientMenuItemTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 22/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "AMClient+MenuItem.h"
#import "TestToolBox.h"

SPEC_BEGIN(AMClientMenuItemTests)

describe(@"AMClient+AMMenuItem", ^{
    context(@"on error free flow", ^{
       context(@"on find menu item", ^{
           __block NSURLSessionDataTask *task;
           __block AMMenuItem *foundItem;
           beforeAll(^{
            [TestToolBox stubRequestWithURL:[baseURL stringByAppendingString:@"menu_items/1"]
                                 httpMethod:@"GET"
                         nameOfResponseFile:@"menu_item.json"
                               responseCode:200];
               
              task = [[AMClient sharedClient] findMenuItemWithIdentifier:@"1" completion:^(AMMenuItem *item, NSError *error) {
                  foundItem = item;
              }];
           });
           
           it(@"uses GET method", ^{
               [[task.originalRequest.HTTPMethod should] equal:@"GET"];
           });
           
           it(@"calls /menu_items/1", ^{
               [[task.originalRequest.URL.absoluteString should] equal:[baseURL stringByAppendingString:@"menu_items/1"]];
           });
           
           it(@"creates menu item object", ^{
               [[expectFutureValue(foundItem) shouldEventually] equal:[TestToolBox objectFromJSONFromFile:@"menu_item.json"]];
           });
       });
    });
});

SPEC_END