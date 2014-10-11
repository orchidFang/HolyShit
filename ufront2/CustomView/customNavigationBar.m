//
//  customNavigationBar.m
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "customNavigationBar.h"
#import "Utils.h"

@implementation customNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //设置导航栏背景图片
        if ([Utils getSystemVersion] >= 7.0) {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];
            [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        }else
        {
            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
        }
        
        //设置导航栏文本颜色
        [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor],UITextAttributeFont:[UIFont systemFontOfSize:20.0f]}];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
