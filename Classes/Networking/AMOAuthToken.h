//
//  AMOAuthToken.h
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

typedef NS_ENUM(NSUInteger, AMOAuthTokenType)
{
    AMOAuthTokenTypeBearer
};

typedef NS_OPTIONS(NSUInteger, AMOAuthScope)
{
    AMOAuthScopeNone = 0,
    AMOAuthScopeBasic = 1 << 0,
    AMOAuthScopeAdmin = 1 << 1,
    AMOAuthScopeTrusted = 1 << 2,
    AMOAuthScopeUser = 1 << 3,
    AMOAuthScopeDeveloper = 1 << 4,
    AMOAuthScopeOwner = 1 << 5,
    AMOAuthScopeGetMenus = 1 << 6,
    AMOAuthScopeAddMenus = 1 << 7,
    AMOAuthScopeAddActiveMenus = 1 << 8,
    AMOAuthScopeGetCurrentOrders = 1 << 9,
    AMOAuthScopeAddOrders = 1 << 10,
    AMOAuthScopeUpdateOrders = 1 << 11,
    AMOAuthScopeGetGroups = 1 << 12,
    AMOAuthScopeCreateGroups = 1 << 13,
    AMOAuthScopeGetDevices = 1 << 14,
    AMOAuthScopeCreateDevices = 1 << 15,
    AMOAuthScopeGetStaffKinds = 1 <<  16,
    AMOAuthScopeCreateStaffKinds = 1 << 17,
    AMOAuthScopeGetStaffMembers = 1 << 18,
    AMOAuthScopeCreateStaffMembers = 1 << 19
};

typedef NS_ENUM(NSUInteger, AMOAuthGrantType) {
    AMOAuthGrantTypePassword,
    AMOAuthGrantTypeCredential,
};

@interface AMOAuthToken : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong, readonly) NSString *token;
@property (nonatomic, strong, readonly) NSString *refreshToken;
@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, strong, readonly) NSDate *expiresAt;
@property (nonatomic, strong, readonly) NSArray *scopes;
+(NSDictionary *)numberToScopesMapping;
+(NSDictionary *)scopesToNumberMapping;
+(NSArray *)stringsFromOptions:(AMOAuthScope)scope;
+(NSString *)stringFromOption:(AMOAuthScope)scope;
+(AMOAuthScope)allScopes;
@end


 