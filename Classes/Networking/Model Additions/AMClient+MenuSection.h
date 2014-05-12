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

-(NSURLSessionDataTask *)findMenuSectionWithIdentifier:(NSString *)identifier
                                            completion:(MenuSectionCompletion)completion;

-(NSURLSessionDataTask *)updateMenuSection:(AMMenuSection *)section
                               withNewName:(NSString *)name
                            newDescription:(NSString *)description
                    newStaffKindIdentifier:(NSString *)identifier
                                completion:(MenuSectionCompletion)completion;

-(NSURLSessionDataTask *)deleteMenuSection:(AMMenuSection *)section
                                completion:(MenuSectionCompletion)completion;

/*
 Menu Section > Menu Items
 */

-(NSURLSessionDataTask *)createItemOfSection:(AMMenuSection *)section
                                    withName:(NSString *)name
                                 description:(NSString *)description
                                       price:(NSNumber *)price
                                    currency:(NSString *)currency
                                 staffKindId:(NSString *)staffKindIdentifier
                                      avatar:(UIImage *)avatar
                                  completion:(MenuSectionItemCompletion)completion;

-(NSURLSessionDataTask *)findItemsOfSection:(AMMenuSection *)section
                                 completion:(MenuSectionItemsCompletion)completion;

@end
