//
//  UFAddressBook.h
//  ufront
//
//  Created by cyyun on 14-4-23.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UFAddressBook : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phoneNumber;
@property(nonatomic,strong)NSNumber *localID;

@end
