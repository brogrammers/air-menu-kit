//
//  AMOAuthApplication.h
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 *  AMOAuthApplication represents a registered application within a system.
 */
@interface AMOAuthApplication : MTLModel <MTLJSONSerializing>
/**
 *  Unique identifier
 */
@property (nonatomic, strong, readonly) NSString *identifier;

/**
 *  Name of the application
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 *  Rerirect URL
 */
@property (nonatomic, strong, readonly) NSURL *redirectUri;

/**
 *  Client id of the application
 */
@property (nonatomic, strong, readonly) NSString *clientId;

/**
 *  Client secret of the application
 */
@property (nonatomic, strong, readonly) NSString *clientSecret;


/**
 *  Get reference to application
 *
 *  @return shared singleton application;
 */
+(AMOAuthApplication *)sharedApplication;

/**
 *  Set shared application
 *
 *  @param application new singleton application
 */
+(void)setSharedApplication:(AMOAuthApplication *)application;

/**
 *  Create application
 *
 *  @param clientId     client id of the application
 *  @param clientSecret client secret of the application
 *
 *  @return new application
 */
+(AMOAuthApplication *)applicationWithClientId:(NSString *)clientId
                                  clientSecret:(NSString *)clientSecret;

/**
 *  Create application
 *
 *  @param identifier   identifier of the application
 *  @param name         name of the application
 *  @param url          url of the application
 *  @param clientId     client id of the application
 *  @param clientSecret clietn secret of the application
 *
 *  @return new applications
 */
+(AMOAuthApplication *)applicationWithIdentifier:(NSString *)identifier
                                            name:(NSString *)name
                                     redirectUri:(NSURL *)url
                                        clientId:(NSString *)clientId
                                    clientSecret:(NSString *)clientSecret;

/**
 *  Initializer of application
 *
 *  @param identifier   identifier of the application
 *  @param name         name of the application
 *  @param url          url of the application
 *  @param clientId     client id of the application
 *  @param clientSecret client secret of the application
 *
 *  @return initalized applicaiton
 */
-(instancetype)initWithIdentifier:(NSString *)identifier
                             name:(NSString *)name
                      redirectUri:(NSURL *)url
                         clientId:(NSString *)clientId
                     clientSecret:(NSString *)clientSecret;
@end
