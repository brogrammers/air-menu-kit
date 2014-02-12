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

@interface AMClient : AFHTTPSessionManager
-(void)authenticateApplication:(AMOAuthApplication *)application
                      withUser:(AMUser *)user
                         scope:(AMOAuthScope)scope
                     grantType:(AMOAuthGrantType)grantType;
@end
