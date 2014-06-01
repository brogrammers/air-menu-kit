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
/**
 *  GET /devices/:id
 *
 *  @param identifier identifier of device - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)findDeviceWithIdentifier:(NSString *)identifier
                                       completion:(DeviceCompletion)completion;

/**
 *  PUT /devices/:id
 *
 *  @param device     device to update - required
 *  @param name       new device name
 *  @param uuid       new device uuid
 *  @param token      new device token
 *  @param platform   new device platform
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)updateDevice:(AMDevice *)device
                          withNewName:(NSString *)name
                              newUUID:(NSString *)uuid
                             newToken:(NSString *)token
                          newPlatform:(NSString *)platform
                           completion:(DeviceCompletion)completion;

/**
 *  DELETE /devices/:id
 *
 *  @param device     device to delete - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */

-(NSURLSessionDataTask *)deleteDevice:(AMDevice *)device
                           completion:(DeviceCompletion)completion;
@end
