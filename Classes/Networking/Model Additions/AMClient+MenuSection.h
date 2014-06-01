//
//  AMClient+MenuSection.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMMenuSection.h"
#import "AMMenuItem.h"

typedef void (^MenuSectionCompletion) (AMMenuSection *section, NSError *error);
typedef void (^MenuSectionItemCompletion) (AMMenuItem *item, NSError *error);
typedef void (^MenuSectionItemsCompletion) (NSArray *items, NSError *error);

@interface AMClient (MenuSection)

/**
 *  GET /menu_sections/:id
 *
 *  @param identifier identifier of menu section - required
 *  @param completion block to executed upon completion
 *
 *  @return data task spawned
 */

-(NSURLSessionDataTask *)findMenuSectionWithIdentifier:(NSString *)identifier
                                            completion:(MenuSectionCompletion)completion;

/**
 *  PUT /menu_sections/:id
 *
 *  @param section     section to be updated
 *  @param name        new name of section
 *  @param description new description of section
 *  @param identifier  new staff kind identifier of section
 *  @param completion  block to be executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)updateMenuSection:(AMMenuSection *)section
                               withNewName:(NSString *)name
                            newDescription:(NSString *)description
                    newStaffKindIdentifier:(NSString *)identifier
                                completion:(MenuSectionCompletion)completion;

/**
 *  DELETE - /menu_sections/:id
 *
 *  @param section    section to delete - required
 *  @param completion block to execute upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)deleteMenuSection:(AMMenuSection *)section
                                completion:(MenuSectionCompletion)completion;

/**
 *  POST - /menu_sections/:id/menu_items
 *
 *  @param section             section to create menu item form - required
 *  @param name                menu item name
 *  @param description         menu item description
 *  @param price               menu item price
 *  @param currency            currency of item price
 *  @param staffKindIdentifier identifier of staff kind responsible for handling item
 *  @param avatar              image that serves as avatar
 *  @param completion          block to execute upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)createItemOfSection:(AMMenuSection *)section
                                    withName:(NSString *)name
                                 description:(NSString *)description
                                       price:(NSNumber *)price
                                    currency:(NSString *)currency
                                 staffKindId:(NSString *)staffKindIdentifier
                                      avatar:(UIImage *)avatar
                                  completion:(MenuSectionItemCompletion)completion;

/**
 *  GET - /menu_sections/:id/menu_items
 *
 *  @param section    section of menu items - required
 *  @param completion block to execute upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findItemsOfSection:(AMMenuSection *)section
                                 completion:(MenuSectionItemsCompletion)completion;

@end
