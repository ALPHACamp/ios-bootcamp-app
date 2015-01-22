//
//  WelcomeViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius =5.0f;
    self.signupButton.layer.cornerRadius =5.0f;
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
