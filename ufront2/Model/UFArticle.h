//
//  UFArticle.h
//  ufront
//
//  Created by cyyun on 14-5-22.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFArticle : NSObject
@property(nonatomic,copy) NSString* id;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *summary;
@property(nonatomic,strong) NSDate *create_date;
@property(nonatomic,copy) NSString *picPath;

@end
