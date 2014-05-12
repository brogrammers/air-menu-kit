//
//  AMClient+Device.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMDevice.h"

typedef void (^DeviceCompletion)(AMDevice *device, NSError *error);

@interface AMClient (Device)
-(NSURLSessionDataTask *)findDeviceWithIdentifier:(NSString *)identifier
                                       completion:(DeviceCompletion)completion;

-(NSURLSessionDataTask *)updateDevice:(AMDevice *)device
                          withNewName:(NSString *)name
                              newUUID:(NSString *)uuid
                             newToken:(NSString *)token
                          newPlatform:(NSString *)platform
                           completion:(DeviceCompletion)completion;

-(NSURLSessionDataTask *)deleteDevice:(AMDevice *)device
                           completion:(DeviceCompletion)completion;
@end
