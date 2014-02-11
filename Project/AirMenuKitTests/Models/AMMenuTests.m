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
                                                   @"createdAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"updatedAt" : [NSDate dateWithTimeIntervalSince1970:1],
                                                   @"name" : @"a name",
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
        
        it(@"has createdAt attribute", ^{
            [[menu.createdAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has updatedAt attribute", ^{
            [[menu.updatedAt should] equal:[NSDate dateWithTimeIntervalSince1970:1]];
        });
        
        it(@"has name attribute", ^{
            [[menu.name should] equal:@"a name"];
        });
        
        it(@"has menu sections attribute", ^{
            [[menu.menuSections should] equal:@[[AMMenuSection new], [AMMenuSection new]]];
        });
    });
    
    context(@"class", ^{
        it(@"returns correct mapping from +JSONKeyPathsByPropertyKey", ^{
            NSDictionary *mapping = [AMMenu JSONKeyPathsByPropertyKey];
            NSDictionary *expectedMapping = @{@"identifier" : @"id",
                                              @"createdAt" : @"created_at",
                                              @"updatedAt" : @"updated_at",
                                              @"name" : @"name",
                                              @"menuSections": @"menu_sections"};
            [[mapping should] equal:expectedMapping];
        });
        
        it(@"implements createdAtJSONTransformer", ^{
            [[[AMMenu class] should] respondToSelector:NSSelectorFromString(@"createdAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from createdAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMMenu class], NSSelectorFromString(@"createdAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
        });
        
        it(@"implements updatedAtJSONTransformer", ^{
            [[[AMMenu class] should] respondToSelector:NSSelectorFromString(@"updatedAtJSONTransformer")];
        });
        
        it(@"returns NSDate transformer from updatedAtJSONTransformer", ^{
            NSValueTransformer *valueTransformer = objc_msgSend([AMMenu class], NSSelectorFromString(@"updatedAtJSONTransformer"));
            [[valueTransformer shouldNot] beNil];
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
                                                    @"created_at" : @"2011-04-05T11:29:14Z",
                                                    @"updated_at" : @"2011-04-05T11:29:14Z",
                                                    @"name" : @"Main Courses",
                                                    @"description" : @"Tasty stuff"};
            parsedMenuSectionsJSON = @[[parsedMenuSectionJSON copy], [parsedMenuSectionJSON copy]];
            
            parsedMenuJSON = @{@"id" : @"1",
                               @"created_at" : @"2011-04-05T11:29:14Z",
                               @"updated_at" : @"2011-04-05T11:29:14Z",
                               @"name" : @"Sunday menu",
                               @"menu_sections" : parsedMenuSectionsJSON};
            menu = [MTLJSONAdapter modelOfClass:[AMMenu class] fromJSONDictionary:parsedMenuJSON error:nil];
        });
        
        it(@"maps parsed menu JSON to AMMenu object", ^{
            [[menu.identifier should] equal:@"1"];
            [[menu.createdAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
            [[menu.updatedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
            [[menu.name should] equal:@"Sunday menu"];
        });
        
        it(@"maps parsed menu section JSON hoops it up to AMMenu object", ^{
           for(AMMenuSection *section in menu.menuSections)
           {
               [[section.identifier should] equal:@"1"];
               [[section.createdAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
               [[section.updatedAt should] equal:[[NSDateFormatter sharedAirMenuFormatter] dateFromString:@"2011-04-05T11:29:14Z"]];
               [[section.name should] equal:@"Main Courses"];
               [[section.details should] equal:@"Tasty stuff"];
           }
        });
    });
});

SPEC_END