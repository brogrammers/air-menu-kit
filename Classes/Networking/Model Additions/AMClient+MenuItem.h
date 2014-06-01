//
//  AMClient+MenuItem.h
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient.h"
#import "AMMenuItem.h"

typedef void (^MenuItemCompletion)(AMMenuItem *item, NSError *error);

@interface AMClient (MenuItem)

/**
 *  GET /menu_items/:id
 *
 *  @param identifier identifier of menu item - required
 *  @param completion block to execute upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)findMenuItemWithIdentifier:(NSString *)identifier
                                         completion:(MenuItemCompletion)completion;

/**
 *  PUT /menu_items/:id
 *
 *  @param item                item to update - required
 *  @param name                menu item new name
 *  @param description         menu item new description
 *  @param price               manu item new price
 *  @param currency            menu item price new currency
 *  @param staffKindIdentifier new identifier of staff kind responsible
 *  @param avatar              new image to be used as the avatar
 *  @param completion          block to be executed upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)updateMenuItem:(AMMenuItem *)item
                            withNewName:(NSString *)name
                         newDescription:(NSString *)description
                               newPrice:(NSNumber *)price
                            newCurrency:(NSString *)currency
                         newStaffKindId:(NSString *)staffKindIdentifier
                                 avatar:(UIImage *)avatar
                             completion:(MenuItemCompletion)completion;

/**
 *  DELETE /menu_items/:id
 *
 *  @param menuItem   item to dalete - required
 *  @param completion block to execute upon completion
 *
 *  @return data task spawned
 */
-(NSURLSessionDataTask *)deleteMenuItem:(AMMenuItem *)menuItem
                             completion:(MenuItemCompletion)completion;

@end
