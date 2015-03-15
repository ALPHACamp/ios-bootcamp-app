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
#import "ACAltas.h"

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
    // To show up keyboard automatically
    [self.emailTextField becomeFirstResponder];
    
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
    [manager POST:@"https://dojo.alphacamp.co/api/v1/login"
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

@end
