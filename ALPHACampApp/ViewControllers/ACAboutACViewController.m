//
//  ACAboutACViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/3/4.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "ACAboutACViewController.h"
#import "WelcomeViewController.h"
#import <AFNetworking/AFNetworking.h> 
#import "ACAltas.h"

@interface ACAboutACViewController ()

@end

@implementation ACAboutACViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 25)];
    imageView.image = [UIImage imageNamed:@"ALPHACamp"];
    
    self.navigationItem.titleView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 25)];
    [self.navigationItem.titleView addSubview:imageView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
