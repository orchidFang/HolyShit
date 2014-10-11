//
//  VersionManager.h
//  ufront2
//
//  Created by cyyun on 14-9-22.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionBlockWithNewVersion)(int hasNewVersion);
@interface VersionManager : NSObject

@property(nonatomic, copy) CompletionBlockWithNewVersion completionBlock;

-(void)checkNewVersion;

@end
