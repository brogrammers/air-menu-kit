//
//  AMObjectBuilderTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMObjectBuilder.h"
#import "AMOAuthToken.h"

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
});

SPEC_END