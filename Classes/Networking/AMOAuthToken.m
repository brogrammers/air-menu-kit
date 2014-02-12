//
//  AMOAuthToken.m
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMOAuthToken.h"
#import <ObjectiveSugar/NSNumber+ObjectiveSugar.h>

@implementation AMOAuthToken

#pragma mark - Mantle framework mapping hooks

+(NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"token" : @"token",
             @"refreshToken" : @"refresh_token",
             @"type" : @"token_type",
             @"expiresAt" : @"expires_in_seconds",
             @"scopes": @"scopes"};
}

+(NSValueTransformer *)expiresAtJSONTransformer
{
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *seconds) {
        return [NSDate dateWithTimeIntervalSinceNow:[seconds intValue]];
    } reverseBlock:^(NSDate *date) {
        return @(0);
    }];
}

-(BOOL)hasScope:(AMOAuthScope)scope
{
    return [self.scopes includes:[self stringValueOfScope:scope]];
}

-(BOOL)isOfType:(AMOAuthTokenType)type
{
    return [self.type isEqualToString:[self stringValueOfType:type]];
}

-(NSString *)stringValueOfScope:(AMOAuthScope)scope
{
    switch (scope)
    {
        case AMOAuthScopeNone:
            return nil;
        break;
            
        case AMOAuthScopeBasic:
            return @"basic";
        break;
        
        case AMOAuthScopeUser:
            return @"user";
        break;
        
        case AMOAuthScopeAdmin:
            return @"admin";
        break;
        
        case AMOAuthScopeCreateCompany:
            return @"create_company";
        break;
    }
}

-(NSString *)stringValueOfType:(AMOAuthTokenType)type
{
    switch (type)
    {
        case AMOAuthTokenTypeBearer:
            return @"bearer";
        break;
    }
}
@end
