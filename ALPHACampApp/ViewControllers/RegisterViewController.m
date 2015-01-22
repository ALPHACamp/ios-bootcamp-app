//
//  RegisterViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerButtonPressed:(id)sender {

    
    UITabBarController *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [tabBarVC setSelectedIndex:0];
    [self presentViewController:tabBarVC animated:YES completion:nil];
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
