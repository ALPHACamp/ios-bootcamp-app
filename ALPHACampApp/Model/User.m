//
//  User.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/27.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "User.h"

@implementation User

+(id)initWithfirstName:(NSString *)firstName lastName:(NSString *)lastName{
    
    User * user =[[User alloc]init];
    user.firstName =firstName;
    user.lastName =lastName;
    
    return user;
}

@end
