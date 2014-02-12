//
//  AMClientTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <objc/message.h>
#import <Kiwi/Kiwi.h>
#import "AMClient.h"

#define DEFAULT_HEADERS withHeaders(@{ @"Accept-Language": @"en;q=1, fr;q=0.9, de;q=0.8, zh-Hans;q=0.7, zh-Hant;q=0.6, ja;q=0.5", @"Content-Length": @"219", @"Content-Type": @"application/x-www-form-urlencoded; charset=utf-8", @"User-Agent": @"(null)/(null) (iPhone Simulator; iOS 7.1; Scale/2.00)" })

SPEC_BEGIN(AMClientTests)

describe(@"AMMenuClient", ^{
    

    
    it(@"implements sharedClient as singleton", ^{
        [[[AMClient sharedClient] should] beIdenticalTo:[AMClient sharedClient]];
    });
    
    it(@"it executes sucess block and passes the token", ^{
        
        __block AMOAuthToken *accessToken;
        [[AMClient sharedClient] authenticateWithClientID:@"1ea6342ac153d74ac305e04f949da93bad3eab7401d9160206e65288bfabee64"
                                             clientSecret:@"541b2f36d19a717077195286212aa1e1cea63faea4cfa22963475512704a2684"
                                                 username:@"rob"
                                                 password:@"password123"
                                                    scope:@"admin" success:^(AMOAuthToken *token) {
                                                        accessToken = token;
                                                    }
                                                  failure:^(NSError *error){}];
        //[[expectFutureValue(accessToken) shouldEventually] beNonNil];
    });
});

SPEC_END