//
//  AMClient+StaffMember.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+StaffMember.h"
#import "AMObjectBuilder.h"

@implementation AMClient (StaffMember)
-(NSURLSessionDataTask *)findStaffMemberWithIdentifier:(NSString *)identifier
                                            completion:(StaffMemberCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"staff_members/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMStaffMember *member = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(member, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateStaffMember:(AMStaffMember *)staffMember
                               WithNewName:(NSString *)name
                               newPassword:(NSString *)password
                                  newEmail:(NSString *)email
                            newStaffKindId:(NSString *)staffKindIdentifier
                                completion:(StaffMemberCompletion)completion
{
    NSAssert(staffMember.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"staff_members/" stringByAppendingString:staffMember.identifier.description];
    NSDictionary *params = @{@"name" : name, @"password" : password, @"email" : email, @"staff_kind_id" : staffKindIdentifier};
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMStaffMember *member = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(member, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)deleteStaffMember:(AMStaffMember *)staffMember
                                completion:(StaffMemberCompletion)completion
{
    NSAssert(staffMember.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"staff_members/" stringByAppendingString:staffMember.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMStaffMember *member = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(member, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

@end
