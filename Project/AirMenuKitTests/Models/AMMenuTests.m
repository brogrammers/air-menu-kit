//
//  AMMenuSectionTests.m
//  AirMenuKit
//
//  Created by Robert Lis on 04/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/message.h>
#import "AMMenu.h"
#import "AMMenuSection.h"
#import "NSDateFormatter+AirMenuTimestamp.h"
#import "NSNumberFormatter+AirMenuNumberFormat.h"


SPEC_BEGIN(AMMenuTests)

describe(@"AMMenu", ^{
    context(@"object", ^{
        __block AMMenu *menu;
        beforeAll(^{
            menu = [[AMMenu alloc] init];
            [menu setValuesForKeysWithDictionary:@{@"identifier" : @"1",
                                                   @"name" : @"a name",
                                                   @"isActive" : @YES,
                                                   @"menuSections" : @[[AMMenuSection new], [AMMenuSection new]]}];
        });
        
        it(@"sublcasses MTLModel", ^{
            [[menu should] beKindOfClass:[MTLModel class]];
        });
        
        it(@"conforms to MTLJSONSerializing protocol", ^{
            [[menu should] conformToProtocol:@protocol(MTLJSONSerializing)];
        });
        
        it(@"has identifier attribute", ^{
            [[menu.identifier should] equal:@"1"];
        });
        
        it(@"has name attribute", ^{
            [[menu.name should] equal:@"a name"];
        });
        
        it(@"has menu sections attribute", ^{
            [[menu.menuSections should] equal:@[[AMMenuSection new], [AMMenuSection new]]];
        });
        
        it(@"has isActive attribute", ^{
            [[menu.isActive should] equal:@YES];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from +JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMMenu JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"name" : @"name",
                                              @"menuSections": @"menu_sections",
                                              @"isActive" : @"active"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements menuSectionsJSONTransformer", ^{
            [[[AMMenu class] should] respondToSelector:NSSelectorFromString(@"menuSectionsJSONTransformer")];
        });
        
        it(@"returns array of AMmenuSection transformer from menuSectionsJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMMenu class], NSSelectorFromString(@"menuSectionsJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
    });
    
    context(@"mapping", ^{
        __block AMMenu *menu;
        __block NSDictionary *parsedMenuJSON;
        __block NSArray *parsedMenuSectionsJSON;
        
        beforeAll(^{
            
            NSDictionary *parsedMenuSectionJSON = @{@"id" : @"1",
                                                    @"name" : @"Main Courses",
                                                    @"description" : @"Tasty stuff"};
            parsedMenuSectionsJSON = @[[parsedMenuSectionJSON copy], [parsedMenuSectionJSON copy]];
            
            parsedMenuJSON = @{@"id" : @"1",
                               @"name" : @"Sunday menu",
                               @"menu_sections" : parsedMenuSectionsJSON,
                               @"active" : @YES};
            menu = [MTLJSONAdapter modelOfClass:[AMMenu class] fromJSONDictionary:parsedMenuJSON error:nil];
        });
        
        it(@"maps parsed menu JSON to AMMenu object", ^{
            [[menu.identifier should] equal:@"1"];
            [[menu.name should] equal:@"Sunday menu"];
            [[menu.isActive should] equal:@YES];
        });
        
        it(@"maps parsed menu section JSON hoops it up to AMMenu object", ^{
           for(AMMenuSection *section in menu.menuSections)
           {
               [[section.identifier should] equal:@"1"];
               [[section.name should] equal:@"Main Courses"];
               [[section.details should] equal:@"Tasty stuff"];
           }
        });
    });
});

SPEC_END