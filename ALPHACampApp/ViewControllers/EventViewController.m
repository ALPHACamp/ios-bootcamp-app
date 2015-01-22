//
//  EventViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController ()
@property (strong, nonatomic)UIScrollView * scrollView;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (strong, nonatomic)NSDictionary * contentDict;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //number of views
    NSInteger n = 3;
    
    //build dataArray
    self.dataArray = [[NSMutableArray alloc]initWithCapacity:n];
//    for (int i=0; i<n ; i++) {
//        
//        
//        NSDictionary * dict = @{@"image" :@"image",
//                                @"Title" :@"Github",
//                                @"Date"  :@"Date",
//                                @"Content" : @"Content"
//                                };
//        [self.dataArray addObject:dict];
//    }
    
    
    //set up scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.contentSize= CGSizeMake(self.view.frame.size.width, 80+n*420);
    self.scrollView.backgroundColor = [UIColor colorWithRed:245/255.0f green:244/255.0f blue:240/255.0f alpha:1];
    
    [self.view addSubview:self.scrollView];
   
    //set up views and add on scrollView
    for (int i=0; i<n; i++) {
      int y = 30 + (i*420);
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10, y, self.view.frame.size.width-20, 400)];
        view.layer.cornerRadius =3.0f;
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, self.view.frame.size.width-30, 150)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        imageView.image = [UIImage imageNamed:@"git_pic"];
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, 300, 50)];
        titleLabel.text= @"ihower 的git教室";
        titleLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
        
        UILabel *dateLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 200, 300, 50)];
        dateLabel.text =@"開課日期：2015/2/7";
        dateLabel.textColor =[UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1];
        dateLabel.font =[UIFont fontWithName:@"Helvetica" size:16];

        UITextView *detailTextView =[[UITextView alloc] initWithFrame:CGRectMake(5, 250, self.view.frame.size.width-30, 70)];
        detailTextView.text= @"由 Ruby on Rails 實戰聖經作者 iHower 親自傳授，優秀開發者的必備基本功，從Git 的內部原理、指令操作以及各種開發流程，大師的開發心法第一手分享，千萬不要錯過！";
        
        UIButton * moreInfoButton =[[UIButton alloc]initWithFrame:CGRectMake((view.frame.size.width-180)/2, 350, 180, 40)];
        [moreInfoButton setTitle:@"瞭解更多" forState:UIControlStateNormal];
        [moreInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        moreInfoButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1];
        moreInfoButton.layer.cornerRadius =5.0f;
        [moreInfoButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [view addSubview:imageView];
        [view addSubview:titleLabel];
        [view addSubview:dateLabel];
        [view addSubview:detailTextView];
        [view addSubview:moreInfoButton];
        view.backgroundColor = [UIColor whiteColor];
        
        [self.scrollView addSubview:view];
        
    }
    
    
    
}
-(void)buttonPressed: (id)sender
{
    UIViewController *eventDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"eventDetailViewController"];
    
    [self.navigationController pushViewController:eventDetailVC animated:YES];
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
