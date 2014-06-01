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

/**
 *  GET /staff_kinds/:id
 *
 *  @param identifier identifier of staff kind - required
 *  @param completion block to execute upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findStaffKindWithIdentifier:(NSString *)identifier
                                          completion:(StaffKindCompletion)completion;

/**
 *  PUT /staff_kinds/:id
 *
 *  @param staffKind         staff kind to update - required
 *  @param name              new staff kind name
 *  @param scopes            new staff rights within the system
 *  @param acceptsOrders     can staff kind accept orders
 *  @param acceptsOrderitems can staff kind handle order items preparation
 *  @param completion        block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)updateStaffKind:(AMStaffKind *)staffKind
                             withNewName:(NSString *)name
                               newScopes:(AMOAuthScope)scopes
                        newAcceptsOrders:(BOOL)acceptsOrders
                    newAcceptsOrderItems:(BOOL)acceptsOrderitems
                              completion:(StaffKindCompletion)completion;

/**
 *  DELETE /staff_kinds/:id
 *
 *  @param staffKind  staff kind to delete - required
 *  @param completion block executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)deleteStaffKind:(AMStaffKind *)staffKind
                              completion:(StaffKindCompletion)completion;
@end
