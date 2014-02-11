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

typedef NS_ENUM(NSUInteger, AMOAuthScope)
{
    AMOAuthScopeBasic,
    AMOAuthScopeUser,
    AMOAuthScopeAdmin,
    AMOAuthScopeCreateCompany
};

@interface AMOAuthToken : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong, readonly) NSString *token;
@property (nonatomic, strong, readonly) NSString *refreshToken;
@property (nonatomic, strong, readonly) NSString *type;
@property (nonatomic, strong, readonly) NSDate *expiresAt;
@property (nonatomic, strong, readonly) NSArray *scopes;
-(BOOL)hasScope:(AMOAuthScope)scope;
-(BOOL)isOfType:(AMOAuthTokenType)type;
@end


