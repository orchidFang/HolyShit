//
//  UFAddressBookDAO.m
//  ufront
//
//  Created by cyyun on 14-4-23.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import "UFAddressBookDAO.h"
#include "pinyin.h"
#import "Utils.h"
#import "UFAddressBook.h"
#import "MBProgressHUD.h"

@interface UFAddressBookDAO()

@property(nonatomic,copy)NSMutableArray *allAddressBook;
@property (nonatomic,strong) NSMutableArray *contactListArray;
@property(nonatomic,strong)MBProgressHUD *HUD;

@end

@implementation UFAddressBookDAO

@synthesize allAddressBook = _allAddressBook;
@synthesize parentView = _parentView;

static UFAddressBookDAO* addressBookDAO = nil;

-(NSMutableArray*)allAddressBook
{
    if (_allAddressBook == nil) {
        _allAddressBook = [[NSMutableArray alloc]init];
    }
    return _allAddressBook;
}

-(NSMutableArray*)contactListArray
{
    if (_contactListArray == nil) {
        _contactListArray = [[NSMutableArray alloc] init];
    }
    
    return _contactListArray;
}

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

+(UFAddressBookDAO*)sharedAddressBookDAO
{
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        addressBookDAO = [[UFAddressBookDAO alloc] init];
//    });
    if (addressBookDAO == nil) {
        addressBookDAO = [[UFAddressBookDAO alloc] init];
    }
    return addressBookDAO;
}

-(void)resetAddressBookDAO
{
    addressBookDAO = nil;
}

-(NSMutableArray*)getAllAddressBook
{
    return self.allAddressBook;
}


-(void)setAllAddressBook:(NSMutableArray*)array;
{
    [self.allAddressBook removeAllObjects];
    for (UFAddressBook *addressBook in array) {
        [self.allAddressBook addObject:addressBook];
    }
}

-(NSMutableArray*)getContactListArray
{
    return self.contactListArray;
}

-(void)addAddressBook:(UFAddressBook *)addressBook
{
    [self.allAddressBook addObject:addressBook];
}

-(NSString*)addressBookArchivePath
{
    NSArray *documentDirectoies = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectoies objectAtIndex:0];
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    return [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_addressBook.archive",userName]];;
}

-(BOOL)saveAllAddressBooktoArchive
{
    NSString *savePath = [self addressBookArchivePath];
    return [NSKeyedArchiver archiveRootObject:self.allAddressBook toFile:savePath];
}

-(BOOL)fetchAllAddressBookFromArchive
{
     NSString *path = [self addressBookArchivePath];
    _allAddressBook = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (_allAddressBook) {
        return YES;
    }else
    {
        return NO;
    }
}

-(void)fetchgetAllAddressBookFromServer
{

//    NSString* contactUrl = [NSString stringWithFormat:@"%@/contact.do",commonUrl];
//    NSString* sessionToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"sessionToken"];
//    NSString *requestParams = [NSString stringWithFormat:@"sessionToken=%@",sessionToken];
//    NSLog(@"requestURL:%@?%@",contactUrl,requestParams);
//    UFHttpRequest *httpRequest = [[UFHttpRequest alloc] init];
//    httpRequest.HUD = [MBProgressHUD showHUDAddedTo:self.parentView animated:YES];
//    httpRequest.HUD.labelText = @"正在加载联系人，请稍等";
//    [httpRequest AsynRequestWithUrlStr:contactUrl  paramStr:requestParams completionHandler:^(NSData* data){
//        if (data)
//        {
//            
//            JSONDecoder *decoder = [[JSONDecoder alloc] init];
//            NSDictionary *ret = [decoder objectWithData:data];
//            int resultCode = [[ret objectForKey:@"resultCode"] intValue];
//            if (resultCode == 0) {
//                if (self.contactListArray.count > 0 || self.allAddressBook.count >0) {
//                    [self.contactListArray removeAllObjects];
//                    [self.allAddressBook removeAllObjects];
//                }
//                NSArray *objArray = [ret objectForKey:@"list"];
//                for (NSDictionary *addressBookDic in objArray) {
//                    UFAddressBook *addressBook = [[UFAddressBook alloc]init];
//                    addressBook.name = [addressBookDic objectForKey:@"username"];
//                    addressBook.phoneNumber =[addressBookDic objectForKey:@"loginMobile"];
//                    //NSLog(@"REQUEST:name:%@,phoneNumber:%@",addressBook.name,addressBook.phoneNumber);
//                    [[UFAddressBookDAO sharedAddressBookDAO]addAddressBook:addressBook];
//                }
//                [self showContactList];
//                [self.parentView reloadData];
//                [[UFAddressBookDAO sharedAddressBookDAO]saveAllAddressBooktoArchive];
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

- (NSString*) getFirstLettersFromName:(NSString *)nameString
{
    if (nameString.length == 0) {
        return @"";
    }
    NSString *firstLetterString = [NSString string];
    for (int i=0; i<[nameString length]; i++) {
        char firstLetter = pinyinFirstLetter([nameString characterAtIndex:i]);
        NSString *firstLetterStr = [NSString stringWithFormat:@"%c",firstLetter];
        firstLetterString = [firstLetterString stringByAppendingString:firstLetterStr];
    }
    
    return firstLetterString;
    
    
}

-(void)showContactList
{
    NSMutableArray *pinYinArray = [NSMutableArray new];
    //NSMutableArray *nameMutableArray = [[UFAddressBookDAO sharedAddressBookDAO]getAllAddressBook];
    for (UFAddressBook* addressBook in self.allAddressBook)
    {
        NSString *nameofPinyin = [[self getFirstLettersFromName:addressBook.name] uppercaseString];
        NSDictionary *dic = @{@"addressBook": addressBook, @"pinyin":nameofPinyin};
        
        [pinYinArray addObject:dic];
    }
    
    // 按拼音排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    [pinYinArray sortUsingDescriptors:sortDescriptors];
    
    //建立索引
    //self.contactListArray = [NSMutableArray new];
    
    NSMutableArray *oneGroup = nil;
    NSString *currentkey = @"-1";
    for (NSDictionary *sortedDicItem in pinYinArray)
    {
        NSString *key = [[sortedDicItem objectForKey:@"pinyin"] substringToIndex:1];
        if([Utils isPureInt:key]){
            key = @"#";
        }
        if (![key isEqualToString:currentkey])
        {
            if ((![currentkey isEqualToString:@"-1"]) && ([oneGroup count] != 0))
            {
                NSMutableDictionary *singleGroupContacts = [[NSMutableDictionary alloc] init];
                [singleGroupContacts setValue:oneGroup forKey:currentkey];
                
                // [self.contactsList addObject:singleGroupContacts];
                [self.contactListArray addObject:singleGroupContacts];
            }
            
            oneGroup = [NSMutableArray array];
            currentkey = [NSString stringWithString:key];
            if([Utils isPureInt:currentkey]){
                currentkey = @"#";
            }
        }
        
        [oneGroup addObject:sortedDicItem];
        
        if (sortedDicItem == [pinYinArray lastObject])
        {
            if ([oneGroup count] != 0)
            {
                NSMutableDictionary *singleGroupContacts = [[NSMutableDictionary alloc] init];
                [singleGroupContacts setValue:oneGroup forKey:currentkey];
                
                //[self.contactsList addObject:singleGroupContacts];
                [self.contactListArray addObject:singleGroupContacts];
            }
        }
    }


}

@end
