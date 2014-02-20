//
//  AMObjectBuilderTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <objc/message.h>
#import "AMObjectBuilder.h"
#import "AMOAuthToken.h"
#import "AMRestaurant.h"

SPEC_BEGIN(AMObjectBuilderTests)

describe(@"AMObjectBuilder", ^{
    it(@"implements sharedInstance as singleton", ^{
       [[[AMObjectBuilder sharedInstance] should] beIdenticalTo:[AMObjectBuilder sharedInstance]];
    });
    
    it(@"returns AMOAuthToken", ^{
        NSDictionary *tokenParsedJSON = @{@"access_token" : @{}};
        id object =[[AMObjectBuilder sharedInstance] objectFromJSON:tokenParsedJSON];
        [[object should] beKindOfClass:[AMOAuthToken class]];
    });
    
    it(@"returns array of restaurants when json root is restaurants", ^{
        NSData *restaurantsJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"restaurants.json", nil)];
        NSDictionary *parsedRestaurantsJSON = [NSJSONSerialization JSONObjectWithData:restaurantsJSON options:0 error:nil];
        id restaurants = [[AMObjectBuilder sharedInstance] objectFromJSON:parsedRestaurantsJSON];
        [[restaurants should] beKindOfClass:[NSArray class]];
        [[[restaurants objectAtIndex:0] should] beKindOfClass:[AMRestaurant class]];
        [[[restaurants objectAtIndex:1] should] beKindOfClass:[AMRestaurant class]];
    });
    
    it(@"returns a restaurant when json root is restaurant", ^{
        NSData *restaurantJSON = [NSData dataWithContentsOfFile:OHPathForFileInBundle(@"restaurant.json", nil)];
        NSDictionary *parsedRestaurantJSON = [NSJSONSerialization JSONObjectWithData:restaurantJSON options:0 error:nil];
        [[[[AMObjectBuilder sharedInstance] objectFromJSON:parsedRestaurantJSON ] should] beKindOfClass:[AMRestaurant class]];
    });
});

SPEC_END