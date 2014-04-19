//
//  AMClient+StaffKind.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+StaffKind.h"
#import "AMObjectBuilder.h"

@implementation AMClient (StaffKind)
-(NSURLSessionDataTask *)findStaffKindWithIdentifier:(NSString *)identifier
                                          completion:(StaffKindCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"staff_kinds/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMStaffKind *staffKind = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(staffKind, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateStaffKind:(AMStaffKind *)staffKind
                             withNewName:(NSString *)name
                               newScopes:(AMOAuthScope)scopes
                              completion:(StaffKindCompletion)completion
{
    NSAssert(staffKind.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"staff_kinds/" stringByAppendingString:staffKind.identifier.description];
    return [self PUT:urlString
          parameters:@{@"name" : name, @"scopes" : [AMOAuthToken stringFromOption:scopes]}
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMStaffKind *staffKind = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(staffKind, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)deleteStaffKind:(AMStaffKind *)staffKind
                              completion:(StaffKindCompletion)completion
{
    NSAssert(staffKind.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"staff_kinds/" stringByAppendingString:staffKind.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMStaffKind *staffKind = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(staffKind, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}
@end
