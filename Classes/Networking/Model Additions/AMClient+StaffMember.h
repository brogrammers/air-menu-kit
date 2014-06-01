//
//  AMClient+StaffMember.h
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMStaffMember.h"

typedef void (^StaffMemberCompletion)(AMStaffMember *staffMember, NSError *error);

@interface AMClient (StaffMember)

/**
 *  GET /staff_members/:id
 *
 *  @param identifier identifier of staff member - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findStaffMemberWithIdentifier:(NSString *)identifier
                                            completion:(StaffMemberCompletion)completion;

/**
 *  PUT /staff_members/:id
 *
 *  @param staffMember         staff member to update - required
 *  @param name                new staff member name
 *  @param password            new staff member password
 *  @param email               new staff member email
 *  @param staffKindIdentifier new staff kind identifier
 *  @param avatar              new image to be used as avatar
 *  @param scopes              new rights within the system
 *  @param completion          new completion block
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)updateStaffMember:(AMStaffMember *)staffMember
                               withNewName:(NSString *)name
                               newPassword:(NSString *)password
                                  newEmail:(NSString *)email
                            newStaffKindId:(NSString *)staffKindIdentifier
                                    avatar:(UIImage *)avatar
                                 newScopes:(AMOAuthScope)scopes
                                completion:(StaffMemberCompletion)completion;

/**
 *  DELETE /staff_members/:id
 *
 *  @param staffMember staff member to delete - required
 *  @param completion  completion blok
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)deleteStaffMember:(AMStaffMember *)staffMember
                                completion:(StaffMemberCompletion)completion;

@end
