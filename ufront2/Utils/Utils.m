//
//  Utils.m
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils

//NSString* const commonUrl = @"http://192.168.1.122:8080/ufront/mobile";
//NSString* const picCommonUrl = @"http://192.168.1.122:8080";


NSString* const commonURL = @"http://chonseng.eicp.net:9080";
NSString* const baseURLString = @"http://chonseng.eicp.net:9080/ufront/mobile";
//NSString* const commonUrl = @"http://192.168.1.106:8080/ufront/mobile";

///////////////////////test.cyyun.com/////////////////////

//NSString* const picCommonUrl = @"http://test.cyyun.com:8080";
//NSString* const commonUrl = @"http://test.cyyun.com:8080/ufront/mobile";


/////////////////////www.cyyun.com////////////////////////

//NSString *const commonURL = @"http://www.cyyun.com";
//NSString* const baseURLString = @"http://www.cyyun.com/ufront/mobile";


+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string.length == 0) {
        return YES;
    }
    //去除两端的空格
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (trimmedString.length == 0) {
        return YES;
    }
    return NO;
}

+(NSString*)curAppVersion
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+(float)getSystemVersion
{
    float version = [[[UIDevice currentDevice]systemVersion] floatValue];
    return version;
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+(void)setExtraTableCellLine:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

@end
