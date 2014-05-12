//
//  AMClient+Group.m
//  AirMenuKit
//
//  Created by Robert Lis on 15/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+Group.h"
#import "AMObjectBuilder.h"

@implementation AMClient (Group)

-(NSURLSessionDataTask *)findGroupWithIdentifier:(NSString *)identifier
                                      completion:(GroupCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"groups/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMGroup *group = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(group, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateGroup:(AMGroup *)group
                         withNewName:(NSString *)name
                          completion:(GroupCompletion)completion
{
    NSAssert(group.identifier, @"group identifier cannot be nil");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(name) [params setObject:name forKey:@"name"];
    
    NSString *urlString = [@"groups/" stringByAppendingString:group.identifier.description];
    return [self PUT:urlString
          parameters:params
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMGroup *group = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(group, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}


-(NSURLSessionDataTask *)deleteGroup:(AMGroup *)group
                          completion:(GroupCompletion)completion
{
    NSAssert(group.identifier, @"group identifier cannot be nil");
    NSString *urlString = [@"groups/" stringByAppendingString:group.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMGroup *group = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(group, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

-(NSURLSessionDataTask *)findStaffMembersOfGroup:(AMGroup *)group
                                      completion:(GroupStaffMembersCompletion)completion
{
    NSAssert(group.identifier, @"group identifier cannot be nil");
    NSString *urlString = [NSString stringWithFormat:@"groups/%@/staff_members", group.identifier.description];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 NSArray *staffMembers = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(staffMembers, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)addStaffMember:(AMStaffMember *)staffMember
                                toGroup:(AMGroup *)group
                             completion:(GroupStaffMemberCompletion)completion
{
    NSAssert(group.identifier, @"group identifier cannot be nil");
    NSAssert(staffMember.identifier, @"member identifier cannot be nil");

    NSString *urlString = [NSString stringWithFormat:@"groups/%@/staff_members", group.identifier.description];
    return [self POST:urlString
           parameters:@{@"staff_member_id" : staffMember.identifier.description}
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  AMStaffMember *member  = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                  if(completion) completion(member, nil);
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  if(completion) completion(nil, error);
              }];
}
@end




