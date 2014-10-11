//
//  Utils.h
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

extern  NSString *const baseURLString ;
extern  NSString *const commonURL;


//+(CGFloat)getLabelHeight:(UILabel *)label;
//+(CGFloat)getLabelWidth:(UILabel *)label;
//
//+(CGFloat)getTextViewHeight:(UITextView*)textView;
//字符串判空
+(BOOL)isBlankString:(NSString*)string;
//
+(float)getSystemVersion;
//
////判断设备类型 4/5
//+(int)valueDevice;

//md5加密
+(NSString *)md5:(NSString*)str;

//+(BOOL)is2Gor3G;
//
//+(BOOL)autoReceivePicUnder2Gor3G;
//
//+(void)exitToLogin;
//
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
//
+(NSString*) curAppVersion;
//
+(void)setExtraTableCellLine:(UITableView*)tableView;
//
+(BOOL)isPureInt:(NSString*)string;

@end
