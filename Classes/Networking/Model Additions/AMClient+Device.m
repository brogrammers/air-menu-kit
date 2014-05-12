//
//  AMClient+Device.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/05/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+Device.h"
#import "AMObjectBuilder.h"

@implementation AMClient (Device)
-(NSURLSessionDataTask *)findDeviceWithIdentifier:(NSString *)identifier
                                       completion:(DeviceCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"devices/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMDevice *device = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(device, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateDevice:(AMDevice *)device
                          withNewName:(NSString *)name
                              newUUID:(NSString *)uuid
                             newToken:(NSString *)token
                          newPlatform:(NSString *)platform
                           completion:(DeviceCompletion)completion
{
    NSAssert(device.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"devices/" stringByAppendingString:device.identifier.description];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(name) [params setObject:name forKey:@"name"];
    if(uuid) [params setObject:uuid forKey:@"uuid"];
    if(platform) [params setObject:platform forKey:@"platform"];
    if(token) [params setObject:token forKey:@"token"];
    
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMDevice *device = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(device, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)deleteDevice:(AMDevice *)device
                           completion:(DeviceCompletion)completion
{
    NSAssert(device.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"devices/" stringByAppendingString:device.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMDevice *device = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(device, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);

                }];
}
@end
