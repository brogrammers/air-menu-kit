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

-(NSURLSessionDataTask *)findGroupWithIdentifier:(NSString *)identifier
                                      completion:(GroupCompletion)completion;

-(NSURLSessionDataTask *)updateGroup:(AMGroup *)group
                         withNewName:(NSString *)name
                          completion:(GroupCompletion)completion;


-(NSURLSessionDataTask *)deleteGroup:(AMGroup *)group
                          completion:(GroupCompletion)completion;

-(NSURLSessionDataTask *)findStaffMembersOfGroup:(AMGroup *)group
                                      completion:(GroupStaffMembersCompletion)completion;

-(NSURLSessionDataTask *)addStaffMember:(AMStaffMember *)staffMember
                                toGroup:(AMGroup *)group
                             completion:(GroupStaffMemberCompletion)completion;
@end
