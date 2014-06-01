    //
//  AMClient+Group.h
//  AirMenuKit
//
//  Created by Robert Lis on 15/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMGroup.h"
#import "AMStaffMember.h"

typedef void (^GroupCompletion)(AMGroup *group, NSError *error);
typedef void (^GroupStaffMembersCompletion)(NSArray *staffMembers, NSError *error);
typedef void (^GroupStaffMemberCompletion)(AMStaffMember *staffMember, NSError *error);

@interface AMClient (Group)

/**
 *  GET /groups/:id
 *
 *  @param identifier identifier of group - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */

-(NSURLSessionDataTask *)findGroupWithIdentifier:(NSString *)identifier
                                      completion:(GroupCompletion)completion;

/**
 *  PUT /groups/:id
 *
 *  @param group      group to be updated - required
 *  @param name       new group name
 *  @param completion block to be executed upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)updateGroup:(AMGroup *)group
                         withNewName:(NSString *)name
                          completion:(GroupCompletion)completion;

/**
 *  DELETE /groups/:id
 *
 *  @param group      group to be deleted - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)deleteGroup:(AMGroup *)group
                          completion:(GroupCompletion)completion;

/**
 *  GET /groups/:id/staff_members
 *
 *  @param group      grouo of staff members - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)findStaffMembersOfGroup:(AMGroup *)group
                                      completion:(GroupStaffMembersCompletion)completion;

/**
 *  POST /groups/:id/staff_members
 *
 *  @param staffMember staff member to add to group - required
 *  @param group       grouo to which add staff member to - requried
 *  @param completion  block to exectue upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)addStaffMember:(AMStaffMember *)staffMember
                                toGroup:(AMGroup *)group
                             completion:(GroupStaffMemberCompletion)completion;
@end
