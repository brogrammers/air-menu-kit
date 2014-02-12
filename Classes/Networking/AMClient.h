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
#import "AMUser.h"

static NSString *baseURL = @"https://stage.air-menu.com/api/v1/";

@interface AMClient : AFHTTPSessionManager
@property (nonatomic, strong, readonly) id <AMUser> currentUser;

+(instancetype)sharedClient;

-(NSURLSessionDataTask *)authenticateWithClientID:(NSString *)clientID
                                     clientSecret:(NSString *)clientSecret
                                         username:(NSString *)username
                                         password:(NSString *)password
                                            scope:(NSString *)scope
                                          success:(void(^)(AMOAuthToken *token))success
                                          failure:(void(^)(NSError *error))failure;
@end
