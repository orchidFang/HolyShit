//
//  UFPublicationDAO.m
//  ufront
//
//  Created by cyyun on 14-5-22.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import "UFPublicationDAO.h"

#import "UFNotice.h"
#import "MBProgressHUD.h"
#import "UFPublication.h"
#import "UFArticle.h"
#import "Utils.h"

@interface UFPublicationDAO ()
@property(nonatomic,copy)NSMutableArray *PublicationListArray;
@property(nonatomic,strong)MBProgressHUD *HUD;
@end

static UFPublicationDAO *PublicationDAO = nil;
@implementation UFPublicationDAO

-(NSMutableArray*)PublicationListArray
{
    if (_PublicationListArray == nil) {
        _PublicationListArray = [[NSMutableArray alloc] init];
    }
    
    return _PublicationListArray;
}

-(void)resetPublicationDao
{
    PublicationDAO = nil;
}

+(UFPublicationDAO*)sharedPublicationDAO
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        PublicationDAO = [[UFPublicationDAO alloc] init];
//    });
    
    if (PublicationDAO == nil) {
        PublicationDAO = [[UFPublicationDAO alloc] init];
    }
    
    return PublicationDAO;
}

-(UFPublication*)getPublicationByArticleId:(int)articleId
{
    for (UFPublication* publication in self.PublicationListArray) {
        for (UFArticle* article in publication.articleList) {
            if ([article.id intValue] == articleId) {
                return publication;
            }
        }
    }
    return nil;
}

-(NSMutableArray*)getAllPublication
{
    return self.PublicationListArray;
}

-(void)fetchPublicationFromServerWhenRefresh
{
//    
//    NSString* PublicationUrl = [NSString stringWithFormat:@"%@/recommand.do",commonUrl];
//    NSString* sessionToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"sessionToken"];
//    UFPublication *latestPublication = [self.PublicationListArray objectAtIndex:0];
//    NSLog(@"%@",latestPublication.postTime);
//    long long latestPostTime = [latestPublication.postTime timeIntervalSince1970] *1000;
//    
//    NSString *requestParams = [NSString stringWithFormat:@"sessionToken=%@&pushStyle=1&time=%lld",sessionToken,latestPostTime];
//    NSLog(@"requestURL:%@?%@",PublicationUrl,requestParams);
//    UFHttpRequest *httpRequest = [[UFHttpRequest alloc] init];
//    httpRequest.HUD = [MBProgressHUD showHUDAddedTo:self.parentView animated:YES];
//    httpRequest.HUD.labelText = @"正在加载数据，请稍等";
//    [httpRequest AsynRequestWithUrlStr:PublicationUrl  paramStr:requestParams completionHandler:^(NSData* data){
//        if (data)
//        {
//            JSONDecoder *decoder = [[JSONDecoder alloc] init];
//            NSDictionary *ret = [decoder objectWithData:data];
//            int resultCode = [[ret objectForKey:@"resultCode"] intValue];
//            if (resultCode == 0) {
//                NSArray *objArray = [ret objectForKey:@"list"];
//                int indexOfPublication = 0;
//                for (NSDictionary *PublicationDic in objArray) {
//                    UFPublication *Publication = [[UFPublication alloc]init];
//                    Publication.id = [PublicationDic objectForKey:@"publicationId"];
//                    Publication.title =[PublicationDic objectForKey:@"title"];
//                    Publication.puId = [PublicationDic objectForKey:@"puId"];
//                    Publication.articleNum = [[PublicationDic objectForKey:@"category"] intValue];
//                    Publication.isRead = ([[PublicationDic objectForKey:@"isRead"] intValue] == 1) ?YES:NO;
//                    NSString *dateString = [PublicationDic objectForKey:@"time"];
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSS";
//                    Publication.postTime = [dateFormatter dateFromString:dateString];
//                    
//                    NSString *articleJsonString = [PublicationDic objectForKey:@"articleJson"];
//                    NSMutableString *articleMutableString = [NSMutableString stringWithString:articleJsonString];
//                    [articleMutableString insertString:@"{\"article\":" atIndex:0];
//                    [articleMutableString appendString:@"}"];
//                    NSLog(@"mutableString:%@",articleMutableString);
//                    NSData *articleJsonData = [articleMutableString dataUsingEncoding:NSUTF8StringEncoding];
//                    NSDictionary *articleListDic = [decoder objectWithData:articleJsonData];
//                    NSArray *articleArray = [articleListDic objectForKey:@"article"];
//                    for (NSDictionary* articleDic in articleArray) {
//                        UFArticle *article = [[UFArticle alloc] init];
//                        article.id = [articleDic objectForKey:@"id"];
//                        article.title = [articleDic objectForKey:@"title"];
//                        NSString *dateString = [articleDic objectForKey:@"create_date"];
//                        article.create_date= [dateFormatter dateFromString:dateString];
//                        article.summary = [articleDic objectForKey:@"summary"];
//                        article.picPath = [articleDic objectForKey:@"file_path"];
//                        [Publication.articleList addObject:article];
//                    }
//                    
//                    [self.PublicationListArray insertObject:Publication atIndex:indexOfPublication];
//                    indexOfPublication ++;
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
    
    
}

-(void)fetchPublicationFromServerWhenLoadmore
{
//    NSString* PublicationUrl = [NSString stringWithFormat:@"%@/recommand.do",commonUrl];
//    NSString* sessionToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"sessionToken"];
//    long long oldestPostTime = 0;
//    if ([self.PublicationListArray count] == 0) {
//        double timeInteval = [[NSDate date] timeIntervalSince1970] * 1000;
//        oldestPostTime = timeInteval;
//    }else
//    {
//        UFPublication *latestPublication = [self.PublicationListArray lastObject];
//        
//        oldestPostTime = [latestPublication.postTime timeIntervalSince1970] *1000;
//    }
//    
//    NSString *requestParams = [NSString stringWithFormat:@"sessionToken=%@&pushStyle=2&time=%lld",sessionToken,oldestPostTime];
//    NSLog(@"requestURL:%@?%@",PublicationUrl,requestParams);
//    UFHttpRequest *httpRequest = [[UFHttpRequest alloc] init];
//    httpRequest.HUD = [MBProgressHUD showHUDAddedTo:self.parentView animated:YES];
//    httpRequest.HUD.labelText = @"正在加载数据，请稍等";
//    [httpRequest AsynRequestWithUrlStr:PublicationUrl  paramStr:requestParams completionHandler:^(NSData* data){
//        if (data)
//        {
//            
//            JSONDecoder *decoder = [[JSONDecoder alloc] init];
//            NSDictionary *ret = [decoder objectWithData:data];
//            int resultCode = [[ret objectForKey:@"resultCode"] intValue];
//            if (resultCode == 0) {
//                NSArray *objArray = [ret objectForKey:@"list"];
//                for (NSDictionary *PublicationDic in objArray) {
//                    UFPublication *Publication = [[UFPublication alloc]init];
//                    Publication.id = [PublicationDic objectForKey:@"publicationId"];
//                    Publication.title =[PublicationDic objectForKey:@"title"];
//                    Publication.puId = [PublicationDic objectForKey:@"puId"];
//                    Publication.articleNum = [[PublicationDic objectForKey:@"category"] intValue];
//                    Publication.isRead = ([[PublicationDic objectForKey:@"isRead"] intValue] == 1) ?YES:NO;
//                    NSString *dateString = [PublicationDic objectForKey:@"time"];
//                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//                    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSS";
//                    Publication.postTime = [dateFormatter dateFromString:dateString];
//                    
//                    NSString *articleJsonString = [PublicationDic objectForKey:@"articleJson"];
//                    NSMutableString *articleMutableString = [NSMutableString stringWithString:articleJsonString];
//                    [articleMutableString insertString:@"{\"article\":" atIndex:0];
//                    [articleMutableString appendString:@"}"];
//                    NSLog(@"mutableString:%@",articleMutableString);
//                    NSData *articleJsonData = [articleMutableString dataUsingEncoding:NSUTF8StringEncoding];
//                    NSDictionary *articleListDic = [decoder objectWithData:articleJsonData];
//                    NSArray *articleArray = [articleListDic objectForKey:@"article"];
//                    for (NSDictionary* articleDic in articleArray) {
//                        UFArticle *article = [[UFArticle alloc] init];
//                        article.id = [articleDic objectForKey:@"id"];
//                        article.title = [articleDic objectForKey:@"title"];
//                        NSString *dateString = [articleDic objectForKey:@"create_date"];
//                        article.create_date= [dateFormatter dateFromString:dateString];
//                        article.summary = [articleDic objectForKey:@"summary"];
//                        if([article.summary isEqual:[NSNull null]])
//                        {
//                            article.summary = @"";
//                        }
//                        article.picPath = [articleDic objectForKey:@"file_path"];
//                        [Publication.articleList addObject:article];
//                    }
//                    [self.PublicationListArray addObject:Publication];
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
    
}


//-(NSString *) jsonStringWithString:(NSString *) string{
//    return [NSString stringWithFormat:@"\"%@\"",
//            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
//            ];
//}
@end
