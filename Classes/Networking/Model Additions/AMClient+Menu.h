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

-(NSURLSessionDataTask *)findMenuWithIdentifier:(NSString *)identifier
                                     completion:(MenuCompletion)completion;

-(NSURLSessionDataTask *)deleteMenu:(AMMenu *)menu
                         completion:(MenuCompletion)completion;


-(NSURLSessionDataTask *)updateMenu:(AMMenu *)menu
                          newActive:(BOOL)isActive
                            newName:(NSString *)name
                         completion:(MenuCompletion)completion;

/*
 Menu > Menu Sections
*/

-(NSURLSessionDataTask *)createSectionOfMenu:(AMMenu *)menu
                                    withName:(NSString *)name
                                 description:(NSString *)description
                                 staffKindId:(NSString *)staffKindIdentifier
                                  completion:(MenuSectionCompletion)completion;

-(NSURLSessionDataTask *)findSectionsOfMenu:(AMMenu *)menu
                                 completion:(MenuSectionsCompletion)completion;
@end
