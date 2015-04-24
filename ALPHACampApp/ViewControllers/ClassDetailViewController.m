//
//  ClassDetailViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/22.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "ClassDetailViewController.h"

@interface ClassDetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property(nonatomic) BOOL suppressesIncrementalRendering;
@end

@implementation ClassDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [self.indicatorView startAnimating];
    
    //improve WebView loading performance
    self.suppressesIncrementalRendering =YES;
    
    //set delegate to self
    self.webView.delegate =self;
    
    //set url
    NSURL *url = [NSURL URLWithString:self.webViewURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

// Input user account password while loading webpage.
-(void)webViewDidFinishLoad:(UIWebView *)webView;{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *password = [defaults objectForKey:@"password"];
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByName('user[email]')[0].value = '%@';",userName]];
   [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementsByName('user[password]')[0].value = '%@';",password]];
    // [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('commit')[0].click();"];
    [self.indicatorView stopAnimating];
    self.indicatorView.hidden=YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
