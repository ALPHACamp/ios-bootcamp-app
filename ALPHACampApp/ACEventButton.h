//
//  ACEventButton.h
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/2/2.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ACEventButton : UIButton

@property (nonatomic, strong) PFObject *event;

@end
