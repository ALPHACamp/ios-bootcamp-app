//
//  EventDetailViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/23.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "EventDetailViewController.h"
#import <Parse/Parse.h>

@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;



@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // show navigationBar to go back
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    //setup WebView  URL
    NSURL *url = [NSURL URLWithString:self.eventDetailURL];
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
