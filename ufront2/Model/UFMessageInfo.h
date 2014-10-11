//
//  UFMessageInfo.h
//  ufront
//
//  Created by cyyun on 14-4-24.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFMessageInfo : NSObject
@property(nonatomic,assign) int messageType;
@property(nonatomic,assign) int unReadNum;
@property(nonatomic,copy) NSString* messageTitle;
@property(nonatomic,strong) NSDate* messageDate;

@end
