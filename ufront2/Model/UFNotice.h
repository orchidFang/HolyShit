//
//  UFNotice.h
//  ufront
//
//  Created by cyyun on 14-4-28.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFNotice : NSObject

@property(nonatomic,copy) NSString *id;
@property(nonatomic,copy) NSString *nuId;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *abstract;
@property(nonatomic,strong) NSDate *postTime;
@property(nonatomic,assign) int type;
@property(nonatomic,assign) int isreceipt;
@property(nonatomic,assign) int needReceipt;
@property(nonatomic,assign) BOOL isRead;

@end
