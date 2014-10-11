//
//  UFNoticeDAO.h
//  ufront
//
//  Created by cyyun on 14-4-28.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UFNotice;

@interface UFNoticeDAO : NSObject<UIAlertViewDelegate>

@property(nonatomic,weak) UITableView* parentView;

+(UFNoticeDAO*)sharedNoticeDAO;
-(void)resetNoticeDao;

-(UFNotice*)getNoticeById:(int)id;

-(NSMutableArray*)getAllNotice;

-(void)fetchNoticeFromServerWhenRefresh;
-(void)fetchNoticeFromServerWhenLoadmore;

@end
