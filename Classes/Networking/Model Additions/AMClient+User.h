//
//  AMClient+User.h
//  AirMenuKit
//
//  Created by Robert Lis on 10/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMUser.h"

typedef void (^UserCompletion)(AMUser *user, NSError *error);

@interface AMClient (User)
-(NSURLSessionDataTask *)findUserWithIdentifier:(NSString *)identifier
                                     completion:(UserCompletion)completion;
-(NSURLSessionDataTask *)findCurrentUser:(UserCompletion)completion;

-(NSURLSessionDataTask *)createUserWithName:(NSString *)name
                                   username:(NSString *)username
                                   password:(NSString *)password
                                 completion:(UserCompletion)completion;
@end
