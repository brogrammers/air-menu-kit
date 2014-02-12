//
//  AMOAuthApplication.m
//  AirMenuKit
//
//  Created by Robert Lis on 11/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMOAuthApplication.h"

@interface AMOAuthApplication()
@property (nonatomic, strong, readwrite) NSString *identifier;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSURL *redirectUri;
@property (nonatomic, strong, readwrite) NSString *clientId;
@property (nonatomic, strong, readwrite) NSString *clientSecret;
@end


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


static AMOAuthApplication *sharedApp;
+(AMOAuthApplication *)sharedApplication
{
    return sharedApp;
}

+(void)setSharedApplication:(AMOAuthApplication *)application
{
    if(application)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedApp = application;
        });
    }
}

+(AMOAuthApplication *)applicationWithClientId:(NSString *)clientId
                                  clientSecret:(NSString *)clientSecret
{
    return [self applicationWithIdentifier:nil name:nil redirectUri:nil clientId:clientId clientSecret:clientSecret];
}

+(AMOAuthApplication *)applicationWithIdentifier:(NSString *)identifier
                                            name:(NSString *)name
                                     redirectUri:(NSURL *)url
                                        clientId:(NSString *)clientId
                                    clientSecret:(NSString *)clientSecret
{
    return [[AMOAuthApplication alloc] initWithIdentifier:identifier name:name redirectUri:url clientId:clientId clientSecret:clientSecret];
}

-(instancetype)initWithIdentifier:(NSString *)identifier
                             name:(NSString *)name
                      redirectUri:(NSURL *)url
                         clientId:(NSString *)clientId
                     clientSecret:(NSString *)clientSecret
{
    self = [super init];
    if(self)
    {
        self.identifier = identifier;
        self.name = name;
        self.redirectUri = url;
        self.clientId = clientId;
        self.clientSecret = clientSecret;
    }
    return self;
}

@end
