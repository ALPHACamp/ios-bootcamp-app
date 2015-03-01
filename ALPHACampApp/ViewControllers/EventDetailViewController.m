//
//  EventDetailViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/23.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "EventDetailViewController.h"
#import <Parse/Parse.h>

@interface EventDetailViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic) BOOL suppressesIncrementalRendering;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // show navigationBar to go back
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.suppressesIncrementalRendering =YES;
    [self.indicatorView startAnimating];
    self.webView.delegate = self;
    //setup WebView URL
    NSURL *url = [NSURL URLWithString:self.eventDetailURL];
  NSLog(@"Print URL: %@", url);
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView;{
   self.indicatorView.hidden=YES;
}

@end
