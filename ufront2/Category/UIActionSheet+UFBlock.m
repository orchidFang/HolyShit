//
//  UIActionSheet+UFBlock.m
//  ufront2
//
//  Created by cyyun on 14-10-16.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "UIActionSheet+UFBlock.h"
#import "objc/runtime.h"

@implementation UIActionSheet (UFBlock)

- (void)setCompletionBlock:(UFActionSheetCompletionBlock)completionBlock
{
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY);
    if (completionBlock) {
        self.delegate = self;
    }else{
        self.delegate = nil;
    }
}

- (UFActionSheetCompletionBlock)completionBlock
{
    return objc_getAssociatedObject(self, @selector(completionBlock));
}


#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.completionBlock(actionSheet,buttonIndex);
}

@end
