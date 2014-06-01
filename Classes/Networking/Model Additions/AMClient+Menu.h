    //
//  AMClient+Menu.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMMenu.h"
#import "AMMenuSection.h"

typedef void (^MenuCompletion)(AMMenu *menu, NSError *error);
typedef void (^MenuSectionCompletion)(AMMenuSection *section, NSError *error);
typedef void (^MenuSectionsCompletion)(NSArray *sections, NSError *error);

@interface AMClient (Menu)

/**
 *  GET /menus/:id
 *
 *  @param identifier identifier of menu - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */

-(NSURLSessionDataTask *)findMenuWithIdentifier:(NSString *)identifier
                                     completion:(MenuCompletion)completion;

/**
 *  DELETE /menus/:id
 *
 *  @param menu       menu to delete - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */

-(NSURLSessionDataTask *)deleteMenu:(AMMenu *)menu
                         completion:(MenuCompletion)completion;

/**
 *  PUT /menus/:id
 *
 *  @param menu       menu to update - required
 *  @param isActive   new is active flag
 *  @param name       new menu name
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)updateMenu:(AMMenu *)menu
                          newActive:(BOOL)isActive
                            newName:(NSString *)name
                         completion:(MenuCompletion)completion;

/**
 *  POST /menus/:id/menu_sections
 *
 *  @param menu                menu to create menu section for
 *  @param name                name of menu section
 *  @param description         description of menu section
 *  @param staffKindIdentifier identifier of staff kind responsible for menu section
 *  @param completion          block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)createSectionOfMenu:(AMMenu *)menu
                                    withName:(NSString *)name
                                 description:(NSString *)description
                                 staffKindId:(NSString *)staffKindIdentifier
                                  completion:(MenuSectionCompletion)completion;

/**
 *  GET menus/:id/menu_sections
 *
 *  @param menu       menu of menu sections - required
 *  @param completion block to execute upon completion
 *
 *  @return spawned data task
 */
-(NSURLSessionDataTask *)findSectionsOfMenu:(AMMenu *)menu
                                 completion:(MenuSectionsCompletion)completion;
@end
