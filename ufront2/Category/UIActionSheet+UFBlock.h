//
//  UIActionSheet+UFBlock.h
//  ufront2
//
//  Created by cyyun on 14-10-16.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UFActionSheetCompletionBlock)(UIActionSheet *actionSheet, NSUInteger buttonIndex);
@interface UIActionSheet (UFBlock)<UIActionSheetDelegate>

@property (nonatomic, copy) UFActionSheetCompletionBlock completionBlock;
@end
