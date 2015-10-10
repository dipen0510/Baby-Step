//
//  DataSyncManager.m
//  Baby Step
//
//  Created by Dipen Sekhsaria on 01/04/15.
//  Copyright (c) 2015 Dipen Sekhsaria. All rights reserved.
//

#import "DataSyncManager.h"

@implementation DataSyncManager
@synthesize delegate,serviceKey;


-(void)startGETWebServicesWithBaseURL
{
    NSURL* url;
    url = [NSURL URLWithString:WebServiceURL];
    
    NSLog(@"Service URl::%@/%@",url,self.serviceKey);
    //NSError *theError = nil;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    [manager GET:self.serviceKey parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Response %@",responseObject);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject valueForKey:@"status"] intValue] == 1) {
                [delegate didFinishServiceWithSuccess:(NSMutableDictionary *)responseObject andServiceKey:self.serviceKey];
            }
            else {
                [delegate didFinishServiceWithFailure:[responseObject valueForKey:@"message"]];
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [delegate didFinishServiceWithFailure:@"Server Not Responding"];
        
    }];
    
}


-(void)startPOSTWebServicesWithData:(id)postData
{
    
    NSURL* url;
    url = [NSURL URLWithString:WebServiceURL];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    [manager POST:self.serviceKey parameters:(id)postData success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject valueForKey:@"Status"] isEqualToString:@"Success"]) {
                [delegate didFinishServiceWithSuccess:(NSMutableDictionary *)responseObject andServiceKey:self.serviceKey];
            }
            else {
                [delegate didFinishServiceWithFailure:[responseObject valueForKey:@"Message"]];
            }
            
            
        }
        else {
            [delegate didFinishServiceWithFailure:@"Unexpected network error"];
        }
        
        //}
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [delegate didFinishServiceWithFailure:@"Server Not Responding"];
        
    }];
    
}


@end
