//
//  UFPublication.m
//  ufront
//
//  Created by cyyun on 14-5-22.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import "UFPublication.h"

@implementation UFPublication

-(NSMutableArray *)articleList
{
    if (_articleList == nil) {
        _articleList = [[NSMutableArray alloc] init];
    }
    return _articleList;
}

@end
