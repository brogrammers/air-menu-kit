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
    AMOAuthScopeUser = 1 << 1,
    AMOAuthScopeDeveloper = 1 << 2,
    AMOAuthScopeOwner = 1 << 3,
    AMOAuthScopeGetMenus = 1 << 4,
    AMOAuthScopeAddMenus = 1 << 5,
    AMOAuthScopeAddActiveMenus = 1 << 6,
    AMOAuthScopeTrusted = 1 << 7
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
@end


 