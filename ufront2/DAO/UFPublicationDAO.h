//
//  UFPublicationDAO.h
//  ufront
//
//  Created by cyyun on 14-5-22.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UFPublication;

@interface UFPublicationDAO : NSObject<UIAlertViewDelegate>

@property(nonatomic,weak) UITableView* parentView;

+(UFPublicationDAO*)sharedPublicationDAO;

-(NSMutableArray*)getAllPublication;

-(void)resetPublicationDao;

-(void)fetchPublicationFromServerWhenRefresh;
-(void)fetchPublicationFromServerWhenLoadmore;

-(UFPublication*)getPublicationByArticleId:(int)articleId;
@end
