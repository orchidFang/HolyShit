//
//  UFAddressBook.m
//  ufront
//
//  Created by cyyun on 14-4-23.
//  Copyright (c) 2014年 CYYUN. All rights reserved.
//

#import "UFAddressBook.h"

@implementation UFAddressBook


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _phoneNumber = [coder decodeObjectForKey:@"phoneNumber"];
        _localID = [coder decodeObjectForKey:@"localID"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_phoneNumber forKey:@"phoneNumber"];
    [coder encodeObject:_localID forKey:@"localID"];
}
@end
