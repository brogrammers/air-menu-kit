//
//  TestToolBox.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import <OHHTTPStubs/OHHTTPStubs.h>
#import "TestToolBox.h"
#import "AMObjectBuilder.h"

@implementation TestToolBox
+(NSDictionary *)bodyOfRequest:(NSURLRequest *)request
{
    NSString *requestBody = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
    NSArray *parameters = [requestBody componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for(NSString *parameter in parameters)
    {
        if(![parameter isEqualToString:@""])
        {
            NSMutableArray *keyValue = [[parameter componentsSeparatedByString:@"="] mutableCopy];
            keyValue[0] = [keyValue[0] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            keyValue[1] = [keyValue[1] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
            [params setValue:keyValue[1] forKey:keyValue[0]];
        }
    }
    
    return params;
}

+(void)stubRequestWithURL:(NSString *)url
               httpMethod:(NSString *)httpMethod
       nameOfResponseFile:(NSString *)fileName
             responseCode:(int)code
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
                            return [request.URL.absoluteString isEqualToString:url] &&
                            [request.HTTPMethod isEqualToString:httpMethod];
                        }
                        withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
                            return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(fileName, nil)
                                                                    statusCode:code
                                                                       headers:@{@"Content-Type": @"text/json"}];
                        }
     ];
}

+(id)objectFromJSONFromFile:(NSString *)jsonFileName
{
    NSData *data = [NSData dataWithContentsOfFile:OHPathForFileInBundle(jsonFileName, nil)];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    return [[AMObjectBuilder sharedInstance] objectFromJSON:json];
}

@end
