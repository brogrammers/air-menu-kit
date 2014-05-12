//
//  AirMenuClient.h
//  AirMenuKit
//
//  Created by Robert Lis on 03/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "AMOAuthApplication.h"
#import "AMOAuthToken.h"

typedef void (^AuthenticateCompletion)(AMOAuthToken *token, NSError *error);
typedef void (^ErrorHandler)();

static NSString *baseURL = @"https://edge-api.air-menu.com/api/v1/";
static NSString *airMenuApiErrorDomain = @"com.air-menu.api";

@interface AMClient : AFHTTPSessionManager
@property (nonatomic, readonly, strong) NSDictionary *errorHandlers;
-(void)registerHadnler:(ErrorHandler)handler forErrorCode:(NSString *)code;
+(instancetype)sharedClient;

-(NSURLSessionDataTask *)authenticateWithClientID:(NSString *)clientID
                                     clientSecret:(NSString *)clientSecret
                                         username:(NSString *)username
                                         password:(NSString *)password
                                           scopes:(AMOAuthScope)scopes
                                       completion:(AuthenticateCompletion)completion;

-(NSURLSessionDataTask *)refreshWithClientID:(NSString *)clientID
                                      secret:(NSString *)clientSecret
                                  completion:(AuthenticateCompletion)completion;


-(BOOL)isLoggedIn;

@end
