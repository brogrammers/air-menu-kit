//
//  TestToolBox.h
//  AirMenuKit
//
//  Created by Robert Lis on 19/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestToolBox : NSObject
+(NSDictionary *)bodyOfRequest:(NSURLRequest *)request;
+(void)stubRequestWithURL:(NSString *)url
               httpMethod:(NSString *)httpMethod
       nameOfResponseFile:(NSString *)fileName
             responseCode:(int)code;
+(id)objectFromJSONFromFile:(NSString *)jsonFileName;
@end
