//
//  AMClient+User.h
//  AirMenuKit
//
//  Created by Robert Lis on 10/03/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMUser.h"
#import "AMDevice.h"

typedef void (^UserCompletion)(AMUser *user, NSError *error);
typedef void (^UserDevicesCompletion)(NSArray *devices, NSError *error);
typedef void (^UserDeviceCompletion)(AMDevice *device, NSError *error);
typedef void (^UserNotificationsCompletion)(NSArray *notifications, NSError *error);

@interface AMClient (User)
-(NSURLSessionDataTask *)findUserWithIdentifier:(NSString *)identifier
                                     completion:(UserCompletion)completion;

-(NSURLSessionDataTask *)createUserWithName:(NSString *)name
                                   username:(NSString *)username
                                   password:(NSString *)password
                                 completion:(UserCompletion)completion;

/*
 Current user
 */

-(NSURLSessionDataTask *)findCurrentUser:(UserCompletion)completion;

-(NSURLSessionDataTask *)findDevicesOfCurrentUser:(UserDevicesCompletion)completiom;

-(NSURLSessionDataTask *)createDeviceOfCurrentUserWithName:(NSString *)name
                                                      uuid:(NSString *)uuid
                                                     token:(NSString *)token
                                                  platform:(NSString *)platform
                                                completion:(UserDevicesCompletion)completion;

-(NSURLSessionDataTask *)findNotificationsOfCurrentUser:(UserNotificationsCompletion)completion;

@end
