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

/**
 *  Class that handles communication with AirMenu backend. Check out categories
 *  for model specific requests. The base handles authentication and authorization.
 *  It takes advantage of NSUserDefaults to store and restore "session" data.
 */

@interface AMClient : AFHTTPSessionManager

/**
 *  Registered error handlers ( blocks ) that are executed when error is detected.
 */
@property (nonatomic, readonly, strong) NSDictionary *errorHandlers;
/**
 *  Add new global error handler for specified error code as per HTTP standard.
 *
 *  @param handler block to be executed upon error
 *  @param code    HTTP error code
 */
-(void)registerHandler:(ErrorHandler)handler forErrorCode:(NSString *)code;

/**
 *  Singleton client object.
 *
 *  @return singleton instance of AMClient
 */
+(instancetype)sharedClient;

/**
 *  POST /access_tokens
 *
 *  @param clientID     client id of the registered application
 *  @param clientSecret client secret of the registered application
 *  @param username     username of the authenticating client
 *  @param password     password of the authenticating client
 *  @param scopes       scopes to be requested
 *  @param completion   block exectuted upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)authenticateWithClientID:(NSString *)clientID
                                     clientSecret:(NSString *)clientSecret
                                         username:(NSString *)username
                                         password:(NSString *)password
                                           scopes:(AMOAuthScope)scopes
                                       completion:(AuthenticateCompletion)completion;

/**
 *  POST /access_tokens
 *
 *  @param clientID     client id of the registered application
 *  @param clientSecret client secret of the registered application
 *  @param completion   block executed upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)refreshWithClientID:(NSString *)clientID
                                      secret:(NSString *)clientSecret
                                  completion:(AuthenticateCompletion)completion;

/**
 *  Check if anyone is currently logged in.
 *
 *  @return YES if user is logged in.
 */
-(BOOL)isLoggedIn;

@end
