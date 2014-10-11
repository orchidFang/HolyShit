//
//  UFPublication.h
//  ufront
//
//  Created by cyyun on 14-5-22.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFPublication : NSObject

@property(nonatomic,copy)NSString* id;
@property(nonatomic,strong) NSDate* postTime;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) int articleNum;
@property(nonatomic,copy) NSMutableArray *articleList;
@property(nonatomic,copy) NSString* puId;
@property(nonatomic,assign) BOOL isRead;

@end
