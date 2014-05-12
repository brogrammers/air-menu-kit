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

-(NSURLSessionDataTask *)findStaffMemberWithIdentifier:(NSString *)identifier
                                            completion:(StaffMemberCompletion)completion;

-(NSURLSessionDataTask *)updateStaffMember:(AMStaffMember *)staffMember
                               withNewName:(NSString *)name
                               newPassword:(NSString *)password
                                  newEmail:(NSString *)email
                            newStaffKindId:(NSString *)staffKindIdentifier
                                    avatar:(UIImage *)avatar
                                completion:(StaffMemberCompletion)completion;

-(NSURLSessionDataTask *)deleteStaffMember:(AMStaffMember *)staffMember
                                completion:(StaffMemberCompletion)completion;

@end
