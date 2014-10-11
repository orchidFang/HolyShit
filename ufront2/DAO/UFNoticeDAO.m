//
//  UFNoticeDAO.m
//  ufront
//
//  Created by cyyun on 14-4-28.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import "UFNoticeDAO.h"
#import "UFNotice.h"
#import "MBProgressHUD.h"
#import "UFNotice.h"
@interface UFNoticeDAO()

@property(nonatomic,copy)NSMutableArray *noticeListArray;
@property(nonatomic,strong)MBProgressHUD *HUD;
@end


static UFNoticeDAO *noticeDAO = nil;
@implementation UFNoticeDAO

-(NSMutableArray*)noticeListArray
{
    if (_noticeListArray == nil) {
        _noticeListArray = [[NSMutableArray alloc] init];
    }
    
    return _noticeListArray;
}

-(void)resetNoticeDao{
    noticeDAO = nil;
}

+(UFNoticeDAO*)sharedNoticeDAO
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        noticeDAO = [[UFNoticeDAO alloc] init];
//    });
    if (noticeDAO == nil) {
        noticeDAO = [[UFNoticeDAO alloc] init];
    }
    
    return noticeDAO;
}

-(NSMutableArray*)getAllNotice
{
    return self.noticeListArray;
}

-(UFNotice*)getNoticeById:(int)noticeId
{
    for(UFNotice *notice in self.noticeListArray)
    {
        if(notice.id.intValue == noticeId){
            return notice;
        }
    }
    return nil;
}

-(void)fetchNoticeFromServerWhenRefresh
{
//    
//    NSString* noticeUrl = [NSString stringWithFormat:@"%@/notice.do",commonUrl];
//    NSString* sessionToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"sessionToken"];
//    UFNotice *latestNotice = [self.noticeListArray objectAtIndex:0];
//    NSLog(@"%@",latestNotice.postTime);
//    long long latestPostTime = [latestNotice.postTime timeIntervalSince1970] *1000;
//    
//    NSString *requestParams = [NSString stringWithFormat:@"sessionToken=%@&pushStyle=1&time=%lld",sessionToken,latestPostTime];
//    NSLog(@"requestURL:%@?%@",noticeUrl,requestParams);
//    UFHttpRequest *httpRequest = [[UFHttpRequest alloc] init];
//    httpRequest.HUD = [MBProgressHUD showHUDAddedTo:self.parentView animated:YES];
//    httpRequest.HUD.labelText = @"正在加载数据，请稍等";
//    [httpRequest AsynRequestWithUrlStr:noticeUrl  paramStr:requestParams completionHandler:^(NSData* data){
//        if (data)
//        {
//            
//            JSONDecoder *decoder = [[JSONDecoder alloc] init];
//            NSDictionary *ret = [decoder objectWithData:data];
//            int resultCode = [[ret objectForKey:@"resultCode"] intValue];
//            if (resultCode == 0) {
//                NSArray *objArray = [ret objectForKey:@"list"];
//                int indexOfNotice = 0;
//                for (NSDictionary *NoticeDic in objArray) {
//                    UFNotice *notice = [[UFNotice alloc]init];
//                    notice.id = [NoticeDic objectForKey:@"id"];
//                    notice.title =[NoticeDic objectForKey:@"title"];
//                    notice.nuId = [NoticeDic objectForKey:@"nuId"];
//                    notice.abstract = [NoticeDic objectForKey:@"summary"];
//                    notice.needReceipt = [[NoticeDic objectForKey:@"needReceipt"] intValue];
//                    NSString *dateString = [NoticeDic objectForKey:@"createTime"];
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//                    notice.postTime = [dateFormatter dateFromString:dateString];
//                    
//                    notice.type = [[NoticeDic objectForKey:@"type"] intValue];
//                    notice.isreceipt = [[NoticeDic objectForKey:@"isreceipt"] intValue];
//                    notice.isRead = ([[NoticeDic objectForKey:@"isRead"] intValue] == 1)?YES:NO;
//                    
//                    [self.noticeListArray insertObject:notice atIndex:indexOfNotice];
//                    indexOfNotice ++;
//                }
//                [self.parentView reloadData];
//            }else if(resultCode == -2)
//            {
//                UFAlertView* alertView = [[UFAlertView alloc] initWithTitle:@"提示" message:@"你的账号在其他地方登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录", nil];
//                [alertView show];
//                alertView.block = ^(NSInteger buttonIndex){
//                    if (buttonIndex == 0) {
//                    }else{
//                        [UFUtility exitToLogin];
//                    }
//                };
//                
//            }else{
//                NSString *alertErrorMessage = [ret objectForKey:@"errorMessage"];
//                self.HUD = [MBProgressHUD showHUDAddedTo:self.parentView animated:YES];
//                self.HUD.mode = MBProgressHUDModeText;
//                self.HUD.labelText =alertErrorMessage;
//                self.HUD.yOffset = -50;
//                self.HUD.removeFromSuperViewOnHide = YES;
//                [self.HUD hide:YES afterDelay:1.0];
//                
//            }
//        }
//        
//    }];
//    
//
}

-(void)fetchNoticeFromServerWhenLoadmore
{
//    NSString* noticeUrl = [NSString stringWithFormat:@"%@/notice.do",commonUrl];
//    NSString* sessionToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"sessionToken"];
//    long long oldestPostTime = 0;
//    if ([self.noticeListArray count] == 0) {
//        double timeInteval = [[NSDate date] timeIntervalSince1970] * 1000;
//        oldestPostTime = timeInteval;
//    }else
//    {
//        UFNotice *latestNotice = [self.noticeListArray lastObject];
//        
//        oldestPostTime = [latestNotice.postTime timeIntervalSince1970] *1000;
//    }
//
//    NSString *requestParams = [NSString stringWithFormat:@"sessionToken=%@&pushStyle=2&time=%lld",sessionToken,oldestPostTime];
//    NSLog(@"requestURL:%@?%@",noticeUrl,requestParams);
//    UFHttpRequest *httpRequest = [[UFHttpRequest alloc] init];
//    httpRequest.HUD = [MBProgressHUD showHUDAddedTo:self.parentView animated:YES];
//    httpRequest.HUD.labelText = @"正在加载数据，请稍等";
//    [httpRequest AsynRequestWithUrlStr:noticeUrl  paramStr:requestParams completionHandler:^(NSData* data){
//        if (data)
//        {
//            
//            JSONDecoder *decoder = [[JSONDecoder alloc] init];
//            NSDictionary *ret = [decoder objectWithData:data];
//            int resultCode = [[ret objectForKey:@"resultCode"] intValue];
//            if (resultCode == 0) {
//                NSArray *objArray = [ret objectForKey:@"list"];
//                for (NSDictionary *NoticeDic in objArray) {
//                    UFNotice *notice = [[UFNotice alloc]init];
//                    notice.id = [NoticeDic objectForKey:@"id"];
//                    notice.nuId = [NoticeDic objectForKey:@"nuId"];
//                    notice.title =[NoticeDic objectForKey:@"title"];
//                    notice.abstract = [NoticeDic objectForKey:@"summary"];
//                    notice.needReceipt = [[NoticeDic objectForKey:@"needReceipt"] intValue];
//                    NSString *dateString = [NoticeDic objectForKey:@"createTime"];
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//                    notice.postTime = [dateFormatter dateFromString:dateString];
//                    notice.type = [[NoticeDic objectForKey:@"type"] intValue];
//                    notice.isreceipt = [[NoticeDic objectForKey:@"isreceipt"] intValue];
//                     notice.isRead = ([[NoticeDic objectForKey:@"isRead"] intValue] == 1)?YES:NO;
//                    
//                    [self.noticeListArray addObject:notice];
//                }
//                
//                [self.parentView reloadData];
//            }else if(resultCode == -2)
//            {
//                UFAlertView* alertView = [[UFAlertView alloc] initWithTitle:@"提示" message:@"你的账号在其他地方登录！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"重新登录", nil];
//                [alertView show];
//                alertView.block = ^(NSInteger buttonIndex){
//                    if (buttonIndex == 0) {
//                    }else{
//                        [UFUtility exitToLogin];
//                    }
//                };
//                
//            }else{
//                NSString *alertErrorMessage = [ret objectForKey:@"errorMessage"];
//                self.HUD = [MBProgressHUD showHUDAddedTo:self.parentView animated:YES];
//                self.HUD.mode = MBProgressHUDModeText;
//                self.HUD.labelText =alertErrorMessage;
//                self.HUD.yOffset = -50;
//                self.HUD.removeFromSuperViewOnHide = YES;
//                [self.HUD hide:YES afterDelay:1.0];
//                
//            }
//
//        }
//        
//    }];
//    
//
}


@end
