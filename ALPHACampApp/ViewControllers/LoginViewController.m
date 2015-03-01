//
//  LoginViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <AFNetworking.h>

#define api_key @"21f7814731bbbcc3302fbe06194e53c4993a3976"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic)NSString * auth_token;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login with API
- (IBAction)loginButtonPressed:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{
                                 @"email": self.emailTextField.text,
                                 @"password": self.passwordTextField.text,
                                 @"api_key": api_key};
    [manager POST:@"https://school.alphacamp.co/api/v1/login"
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              UITabBarController *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
              [tabBarVC setSelectedIndex:0];
              [self presentViewController:tabBarVC animated:YES completion:nil];

              
              NSLog(@"JSON: %@", responseObject);
              self.auth_token = [NSString stringWithFormat:@"%@", responseObject[@"auth_token"]];
              
              NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
              [userDefaults setObject:self.auth_token forKey:@"auth_token"];
              [userDefaults setObject:self.emailTextField.text forKey:@"userName"];
              [userDefaults setObject:self.passwordTextField.text forKey:@"password"];
              [userDefaults synchronize];
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Login in Error: %@", error);
              //NSString *erroeMessage = [NSString stringWithFormat:@"%@", error];
              UIAlertController *alert= [UIAlertController alertControllerWithTitle:@"Login failed!!"
                                   message:nil
                            preferredStyle:UIAlertControllerStyleAlert];
              
              UIAlertAction* ok = [UIAlertAction
                                   actionWithTitle:@"OK"
                                             style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action){
                                            self.emailTextField.text=@"";
                                            self.passwordTextField.text=@"";
                                           }];
              [alert addAction:ok];
              [self presentViewController:alert animated:YES completion:nil];

          }];

    
}





#pragma mark - Parse Login
//- (IBAction)loginButtonPressed:(id)sender {
//    
//    [PFUser logInWithUsernameInBackground:self.emailTextField.text password:self.passwordTextField.text
//                                    block:^(PFUser *user, NSError *error) {
//                                        if (user) {
//                                            UITabBarController *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
//                                            [tabBarVC setSelectedIndex:0];
//                                            [self presentViewController:tabBarVC animated:YES completion:nil];
//
//                                        } else {
//                                            UIAlertController * alert=   [UIAlertController
//                                                                          alertControllerWithTitle:@"帳號密碼錯誤，請重新輸入"
//                                                                          message:@"請注意是否大小寫有誤"
//                                                                          preferredStyle:UIAlertControllerStyleAlert];
//                                            
//                                            UIAlertAction* ok = [UIAlertAction
//                                                                 actionWithTitle:@"OK"
//                                                                 style:UIAlertActionStyleDefault
//                                                                 handler:^(UIAlertAction * action)
//                                                                 {
//                                                                     self.emailTextField.text=@"";
//                                                                     self.passwordTextField.text=@"";
//                                                                 }];
//                                            
//                                            [alert addAction:ok];
//                                            
//                                            [self presentViewController:alert animated:YES completion:nil];
//                   }
//                                    }];
//    
//    
//    
//   }



@end
