//
//  AMObjectBuilder.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMObjectBuilder.h"
#import "AMOAuthToken.h"

static NSString *const kAMOAuthToken = @"access_token";

@interface AMObjectBuilder()
@property (nonatomic, strong) NSDictionary *classByJSONKey;
@end

@implementation AMObjectBuilder
+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static AMObjectBuilder *objectBuilder;
    dispatch_once(&onceToken, ^{
        objectBuilder = [AMObjectBuilder new];
    });
    return objectBuilder;
}

-(NSDictionary *)classByJSONKey
{
    if(!_classByJSONKey)
    {
        _classByJSONKey = @{kAMOAuthToken : [AMOAuthToken class]};
    }
    return _classByJSONKey;
}

-(id)objectFromJSON:(NSDictionary *)json
{
    NSString *type = json.allKeys.firstObject;
    Class objectClass = self.classByJSONKey[type];
    NSAssert(objectClass, @"Could not determine the class corresponding to the key in json");
    
    NSError *error;
    id object = [MTLJSONAdapter modelOfClass:objectClass fromJSONDictionary:json error:&error];
    if(error)
    {
        return nil;
    }
    else
    {
        return object;
    }
}
@end
