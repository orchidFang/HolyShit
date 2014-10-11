//
//  VersionManager.m
//  ufront2
//
//  Created by cyyun on 14-9-22.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//


#import "VersionManager.h"
#import "AFNetworking.h"
#import "Utils.h"

@implementation VersionManager

-(void)checkNewVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    NSString* sessionToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"sessionToken"];
    NSString* versionCheckUrl = [NSString stringWithFormat:@"%@/versioncheck.do?sessionToken=%@&device=ic&version=%@",baseURLString,sessionToken,appVersion];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:versionCheckUrl]];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* request,id responseObject){
        NSLog(@"JSON:%@",responseObject);
        
        int hasNewVersion = [[responseObject objectForKey:@"hasNewVersion"] intValue];
        
        NSLog(@"hasNewVersion:%d",hasNewVersion);
        if (_completionBlock != nil) {
            _completionBlock(hasNewVersion);
        }
        
    }failure:^(AFHTTPRequestOperation* request,NSError* error){
        NSLog(@"ERROR:%@",error);
    }];
    [op start];
    
}

@end
