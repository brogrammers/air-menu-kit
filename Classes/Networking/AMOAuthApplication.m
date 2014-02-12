//
//  AMOAuthApplication.m
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMOAuthApplication.h"

@implementation AMOAuthApplication

#pragma mark - Mantle framework mapping hooks

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"identifier" : @"id",
             @"name" : @"name",
             @"redirectUri": @"redirect_uri",
             @"clientId" : @"client_id",
             @"clientSecret" : @"client_secret"};;
}

+(NSValueTransformer *)redirectUriJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NSURL URLWithString:str];
    } reverseBlock:^(NSURL *url) {
        return url.absoluteString;
    }];
}

@end
