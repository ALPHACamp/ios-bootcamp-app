//
//  EventDetailViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/23.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    NSString *fullURL = @"https://www.alphacamp.co/seminars/";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
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
