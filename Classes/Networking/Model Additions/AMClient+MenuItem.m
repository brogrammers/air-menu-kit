//
//  AMClient+MenuItem.m
//  AirMenuKit
//
//  Created by Robert Lis on 12/02/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+MenuItem.h"
#import "AMObjectBuilder.h"

@implementation AMClient (MenuItem)

-(NSURLSessionDataTask *)findMenuItemWithIdentifier:(NSString *)identifier
                                         completion:(MenuItemCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"menu_items/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMMenuItem *item = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(item, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateMenuItem:(AMMenuItem *)item
                            withNewName:(NSString *)name
                         newDescription:(NSString *)description
                               newPrice:(NSNumber *)price
                            newCurrency:(NSString *)currency
                         newStaffKindId:(NSString *)staffKindIdentifier
                                 avatar:(UIImage *)avatar
                             completion:(MenuItemCompletion)completion
{
    NSAssert(item.identifier, @"item dentifier cannot be nil");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(name) [params setObject:name forKey:@"name"];
    if(description) [params setObject:description forKey:@"description"];
    if(currency) [params setObject:currency forKey:@"currency"];
    if(staffKindIdentifier) [params setObject:staffKindIdentifier forKey:@"staff_kind_id"];
    if(price) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"0.00"];
        [params setObject:[numberFormatter stringFromNumber:price] forKey:@"price"];
    }
    NSString *urlString = [@"menu_items/" stringByAppendingString:item.identifier.description];

    if(avatar)
    {
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"PUT"
                                                                                    URLString:[[NSURL URLWithString:[@"menu_items/" stringByAppendingString:item.identifier.description] relativeToURL:self.baseURL] absoluteString]
                                                                                   parameters:params
                                                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                        [formData appendPartWithFormData:UIImagePNGRepresentation(avatar) name:@"avatar"];
                                                                    } error:nil];
        NSURLSessionDataTask *task = [self dataTaskWithRequest:request
                                             completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                                 if (error)
                                                 {
                                                     AMMenuItem *item = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                                                     if (completion) completion(item, error);
                                                 }
                                                 else
                                                 {
                                                     if (completion) completion(nil, error);
                                                 }
                                             }];
        [task resume];
        return task;
    }
    else
    {
        return [self PUT:urlString
              parameters:params
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     AMMenuItem *item = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                     if(completion) completion(item, nil);
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     if(completion) completion(nil, error);
                 }];
    }
}

-(NSURLSessionDataTask *)deleteMenuItem:(AMMenuItem *)menuItem
                             completion:(MenuItemCompletion)completion
{
    NSAssert(menuItem.identifier, @"item identifier cannot be nil");
    NSString *urlString = [@"menu_items/" stringByAppendingString:menuItem.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMMenuItem *item = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(item, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

@end
