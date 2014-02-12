//
//  AMOAuthApplication.h
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AMOAuthApplication : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSURL *redirectUri;
@property (nonatomic, strong, readonly) NSString *clientId;
@property (nonatomic, strong, readonly) NSString *clientSecret;


+(AMOAuthApplication *)sharedApplication;

+(void)setSharedApplication:(AMOAuthApplication *)application;

+(AMOAuthApplication *)applicationWithClientId:(NSString *)clientId
                                  clientSecret:(NSString *)clientSecret;

+(AMOAuthApplication *)applicationWithIdentifier:(NSString *)identifier
                                            name:(NSString *)name
                                     redirectUri:(NSURL *)url
                                        clientId:(NSString *)clientId
                                    clientSecret:(NSString *)clientSecret;

-(instancetype)initWithIdentifier:(NSString *)identifier
                             name:(NSString *)name
                      redirectUri:(NSURL *)url
                         clientId:(NSString *)clientId
                     clientSecret:(NSString *)clientSecret;
@end
