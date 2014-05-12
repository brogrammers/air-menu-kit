//
//  AMClient+StaffMember.m
//  AirMenuKit
//
//  Created by Robert Lis on 19/04/2014.
//  Copyright (c) 2014 air-menu. All rights reserved.
//

#import "AMClient+StaffMember.h"
#import "AMObjectBuilder.h"

@implementation AMClient (StaffMember)
-(NSURLSessionDataTask *)findStaffMemberWithIdentifier:(NSString *)identifier
                                            completion:(StaffMemberCompletion)completion
{
    NSAssert(identifier, @"identifier cannot be nil");
    NSString *urlString = [@"staff_members/" stringByAppendingString:identifier];
    return [self GET:urlString
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 AMStaffMember *member = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                 if(completion) completion(member, nil);
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if(completion) completion(nil, error);
             }];
}

-(NSURLSessionDataTask *)updateStaffMember:(AMStaffMember *)staffMember
                               withNewName:(NSString *)name
                               newPassword:(NSString *)password
                                  newEmail:(NSString *)email
                            newStaffKindId:(NSString *)staffKindIdentifier
                                    avatar:(UIImage *)avatar
                                 newScopes:(AMOAuthScope)scopes
                                completion:(StaffMemberCompletion)completion;

{
    NSAssert(staffMember.identifier, @"identifier cannot be nil");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if(name) [params setObject:name forKey:@"name"];
    if(password) [params setObject:password forKey:@"password"];
    if(email) [params setObject:email forKey:@"email"];
    if(staffKindIdentifier) [params setObject:staffKindIdentifier forKey:@"staff_kind_id"];
    if(scopes != AMOAuthScopeNone) [params setObject:[AMOAuthToken stringFromOption:scopes] forKey:@"scopes"];

    NSString *urlString = [@"staff_members/" stringByAppendingString:staffMember.identifier.description];
    
    if(avatar)
    {
        NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"PUT"
                                                                                    URLString:[[NSURL URLWithString:urlString relativeToURL:self.baseURL] absoluteString]
                                                                                   parameters:params
                                                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                        [formData appendPartWithFormData:UIImagePNGRepresentation(avatar) name:@"avatar"];
                                                                    } error:nil];
        NSURLSessionDataTask *task = [self dataTaskWithRequest:request
                                             completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                                 if (error)
                                                 {
                                                     AMStaffMember *member = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                                                     if (completion) completion(member, error);
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
                     AMStaffMember *member = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                     if(completion) completion(member, nil);
                 }
                 failure:^(NSURLSessionDataTask *task, NSError *error) {
                     if(completion) completion(nil, error);
                 }];
    }
}

-(NSURLSessionDataTask *)deleteStaffMember:(AMStaffMember *)staffMember
                                completion:(StaffMemberCompletion)completion
{
    NSAssert(staffMember.identifier, @"identifier cannot be nil");
    NSString *urlString = [@"staff_members/" stringByAppendingString:staffMember.identifier.description];
    return [self DELETE:urlString
             parameters:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    AMStaffMember *member = [[AMObjectBuilder sharedInstance] objectFromJSON:responseObject];
                    if(completion) completion(member, nil);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    if(completion) completion(nil, error);
                }];
}

@end
