//
//  User.h
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/27.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject

@property (strong, nonatomic)NSString *firstName;
@property (strong, nonatomic)NSString *lastName;
@property (strong, nonatomic)NSString *email;
@property (strong, nonatomic)NSString *intro;
@property (strong, nonatomic)UIImage *image;



+(id)initWithfirstName:(NSString *)firstName lastName:(NSString *)lastName;

@end
