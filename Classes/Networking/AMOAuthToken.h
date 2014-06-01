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
    //menus
    AMOAuthScopeGetMenus = 1 << 6,
    AMOAuthScopeAddMenus = 1 << 7,
    AMOAuthScopeAddActiveMenus = 1 << 8,
    AMOAuthScopeUpdateMenus = 1 << 9,
    AMOAuthScopeDeleteMenus = 1 << 10,
    //orders
    AMOAuthScopeGetOrders = 1 << 11,
    AMOAuthScopeAddOrders = 1 << 12,
    AMOAuthScopeUpdateOrders = 1 << 13,
    //groups
    AMOAuthScopeGetGroups = 1 << 14,
    AMOAuthScopeCreateGroups = 1 << 15,
    AMOAuthScopeUpdateGroups = 1 << 16,
    AMOAuthScopeDeleteGroups = 1 << 17,
    //device
    AMOAuthScopeGetDevices = 1 << 18,
    AMOAuthScopeCreateDevices = 1 << 19,
    AMOAuthScopeUpdateDevices = 1 << 20,
    AMOAuthScopeDeleteDevices = 1 << 21,
    //staff kinds
    AMOAuthScopeGetStaffKinds = 1 <<  22,
    AMOAuthScopeCreateStaffKinds = 1 << 23,
    AMOAuthScopeUpdateStaffKinds = 1 << 24,
    AMOAuthScopeDeleteStaffKinds = 1 << 25,
    //staff members
    AMOAuthScopeGetStaffMembers = 1 << 26,
    AMOAuthScopeCreateStaffMembers = 1 << 27,
    AMOAuthScopeDeleteStaffMembers = 1 << 28,
    AMOAuthScopeUpdateStaffMembers = 1 << 29,
    //payment
    AMOAuthScopeCreatePayments = 1 << 30,
    //hours
    AMOAuthScopeCreateOpeningHours = 1 << 31,
    AMOAuthScopeGetOpeningHours = 1 << 32,
    AMOAuthScopeUpdateOpeningHours = 1 << 33,
    AMOAuthScopeDeleteOpeningHours = 1 << 34
};

typedef NS_ENUM(NSUInteger, AMOAuthGrantType) {
    AMOAuthGrantTypePassword,
    AMOAuthGrantTypeCredential,
    AMOAuthGrantTypeRefresh
};


/**
 *  AMOAuthToken represents OAuth2 implementation of access token.
 */
@interface AMOAuthToken : MTLModel <MTLJSONSerializing>

/**
 * Token string
 */
@property (nonatomic, strong, readonly) NSString *token;

/**
 *  Refresh token string
 */
@property (nonatomic, strong, readonly) NSString *refreshToken;

/**
 *
 */
@property (nonatomic, strong, readonly) NSString *type;

/**
 *  Token expiry date
 */
@property (nonatomic, strong, readonly) NSDate *expiresAt;

/**
 *  Scopes that this token is authenticated for
 */
@property (nonatomic, strong, readonly) NSArray *scopes;

/**
 *  Map of scope numbers to their equivalent string
 *
 *  @return mapping
 */
+(NSDictionary *)numberToScopesMapping;

/**
 *  Map scope string to their equivalent number
 *
 *  @return mapping
 */

+(NSDictionary *)scopesToNumberMapping;
/**
 *  Given scope or'd option map to string array
 *
 *  @param scope or'd scope option
 *
 *  @return array of scope strings
 */
+(NSArray *)stringsFromOptions:(AMOAuthScope)scope;

/**
 *  Given scope or'd option map it to single space separated string
 *
 *  @param scope or'd scope option
 *
 *  @return space separated scopes
 */
+(NSString *)stringFromOption:(AMOAuthScope)scope;

/**
 *  All possible scopes option
 *
 *  @return or'd scope option that represents all possible scopes
 */
+(AMOAuthScope)allScopes;
@end


 