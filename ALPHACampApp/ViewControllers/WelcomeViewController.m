//
//  WelcomeViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "WelcomeViewController.h"
#import <Parse/Parse.h>

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.loginButton.layer.cornerRadius =5.0f;
  self.signupButton.layer.cornerRadius =5.0f;
  self.signupButton.hidden =YES;
  self.loginButton.hidden =YES;
  
  [self.indicator startAnimating];
  
  NSUserDefaults * defaults =[NSUserDefaults standardUserDefaults];
  NSString *auth_token =[defaults objectForKey:@"auth_token"];
  
  // Check user login, if has been login, then present home tabbar controller
  if (auth_token) {
    UITabBarController *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [tabBarVC setSelectedIndex:0];
    [self presentViewController:tabBarVC animated:YES completion:nil];
  } else{
    self.indicator.hidden =YES;
    self.loginButton.hidden =NO;
  }
  
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
