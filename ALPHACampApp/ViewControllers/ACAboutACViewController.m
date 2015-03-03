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

#define api_key @"21f7814731bbbcc3302fbe06194e53c4993a3976"

@interface ACAboutACViewController ()

@end

@implementation ACAboutACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonPressed:(id)sender {
    //[PFUser logOut];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *authToken = [NSString stringWithFormat:@"%@", [userDefaults stringForKey:@"auth_token"]];
    NSDictionary *parameters = @{
                                 @"api_key": api_key,
                                 @"auth_token": authToken};
    [manager POST:@"https://school.alphacamp.co/api/v1/logout"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
              [defaults removeObjectForKey:@"auth_token"];
              
              WelcomeViewController *rootVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeViewController"];
              [self.navigationController pushViewController:rootVC animated:YES];
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Login out Error: %@", error);
          }];
}


@end
