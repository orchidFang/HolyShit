//
//  UFAddressBookDAO.h
//  ufront
//
//  Created by cyyun on 14-4-23.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UFAddressBook;

@protocol AddressBookDelegate <NSObject>

-(void)updateAddressBookArray;

@end

@interface UFAddressBookDAO : NSObject<UIAlertViewDelegate>

@property(nonatomic,weak)UITableView *parentView;
@property(nonatomic,weak)id<AddressBookDelegate> delegate;

//单例
+(UFAddressBookDAO*)sharedAddressBookDAO;

-(void)resetAddressBookDAO;

//待优化，应该返回NSArray，不应该把可变的Collection公开，而应该提供相应的方法修改对象中的可变Collection
-(NSMutableArray*)getAllAddressBook;
-(void)setAllAddressBook:(NSMutableArray*)array;

-(NSMutableArray*)getContactListArray;

- (NSString*) getFirstLettersFromName:(NSString *)nameString;

//存储在本地的路径
-(NSString *)addressBookArchivePath;

//把通讯录保存在本地
-(BOOL)saveAllAddressBooktoArchive;

//取出存储在本地的通讯录
-(BOOL)fetchAllAddressBookFromArchive;

//从服务器端取回通讯录数据
-(void)fetchgetAllAddressBookFromServer;

-(void)showContactList;

-(void)addAddressBook:(UFAddressBook*)addressBook;

@end
