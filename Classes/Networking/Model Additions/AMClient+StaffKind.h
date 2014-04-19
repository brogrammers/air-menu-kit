//
//  AMClient+StaffKind.h
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMStaffKind.h"

typedef void (^StaffKindCompletion)(AMStaffKind *staffKind, NSError *error);


@interface AMClient (StaffKind)
-(NSURLSessionDataTask *)findStaffKindWithIdentifier:(NSString *)identifier
                                          completion:(StaffKindCompletion)completion;

-(NSURLSessionDataTask *)updateStaffKind:(AMStaffKind *)staffKind
                             withNewName:(NSString *)name
                               newScopes:(AMOAuthScope)scopes
                        newAcceptsOrders:(BOOL)acceptsOrders
                    newAcceptsOrderItems:(BOOL)acceptsOrderitems
                              completion:(StaffKindCompletion)completion;

-(NSURLSessionDataTask *)deleteStaffKind:(AMStaffKind *)staffKind
                              completion:(StaffKindCompletion)completion;
@end
