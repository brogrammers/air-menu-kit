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

-(NSURLSessionDataTask *)findMenuItemWithIdentifier:(NSString *)identifier
                                         completion:(MenuItemCompletion)completion;

-(NSURLSessionDataTask *)updateMenuItem:(AMMenuItem *)item
                            withNewName:(NSString *)name
                         newDescription:(NSString *)description
                               newPrice:(NSNumber *)price
                            newCurrency:(NSString *)currency
                         newStaffKindId:(NSString *)staffKindIdentifier
                                 avatar:(UIImage *)avatar
                             completion:(MenuItemCompletion)completion;

-(NSURLSessionDataTask *)deleteMenuItem:(AMMenuItem *)menuItem
                             completion:(MenuItemCompletion)completion;

@end
