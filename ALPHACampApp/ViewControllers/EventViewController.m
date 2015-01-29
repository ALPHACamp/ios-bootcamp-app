//
//  EventViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "EventViewController.h"
#import "EventDetailViewController.h"
#import <Parse/Parse.h>

@interface EventViewController ()
@property (strong, nonatomic)UIScrollView * scrollView;
@property (strong, nonatomic)NSMutableArray *URLArray;
@property (strong, nonatomic)NSDictionary * contentDict;

@end

@implementation EventViewController

//Lazy init MutableArray
- (NSMutableArray *) URLArray {
    if(!_URLArray)
        _URLArray = [@[] mutableCopy]; // @[] 宣告一個Array裡面是空的, mutableCopy就是複製一個Array變成multable,並把指向此multableArray
    return _URLArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //query how many views
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    NSInteger n = [query countObjects];
    
    //setup scrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height)];
    self.scrollView.contentSize= CGSizeMake(self.view.frame.size.width, 100+n*420);
    self.scrollView.backgroundColor = [UIColor colorWithRed:245/255.0f green:244/255.0f blue:240/255.0f alpha:1];
    
    [self.view addSubview:self.scrollView];
    
    
    //setup views and add on scrollView
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            //set up all data for the views
            for (int i=0; i<n; i++) {
                
                //define y of every view
                int y = 30 + (i*420);
                
                //define view size
                UIView * view = [[UIView alloc] initWithFrame:CGRectMake(10, y, self.view.frame.size.width-20, 400)];
                view.layer.cornerRadius =3.0f;
                
                //define imageView size
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, self.view.frame.size.width-30, 150)];
                imageView.backgroundColor = [UIColor lightGrayColor];
                imageView.contentMode = UIViewContentModeScaleToFill;
                
                //download image from Parse
                PFFile *imageFile =objects[i][@"image"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:imageData];
                        imageView.image = image;
                    }
                }];
                
                //define titlelabel size
                UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, self.view.frame.size.width-30, 50)];
                titleLabel.lineBreakMode =NSLineBreakByWordWrapping;
                titleLabel.numberOfLines = 0;
                titleLabel.text=objects[i][@"eventName"];
                titleLabel.font=[UIFont fontWithName:@"Helvetica" size:20];
                
                //define dateLabel
                UILabel *dateLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 205, 300, 30)];
                dateLabel.text =[NSString stringWithFormat:@"開課日期：%@",objects[i][@"dateString"]] ;
                dateLabel.textColor =[UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1];
                dateLabel.font =[UIFont fontWithName:@"Helvetica" size:16];
                
                //define detailTextView
                UITextView *detailTextView =[[UITextView alloc] initWithFrame:CGRectMake(5, 230, self.view.frame.size.width-30, 110)];
                
                detailTextView.text= objects[i][@"content"];
                
                //define button
                UIButton * moreInfoButton =[[UIButton alloc]initWithFrame:CGRectMake((view.frame.size.width-180)/2, 350, 180, 40)];
                [moreInfoButton setTitle:@"瞭解更多" forState:UIControlStateNormal];
                [moreInfoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                moreInfoButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1];
                moreInfoButton.layer.cornerRadius =5.0f;
                moreInfoButton.tag=i;
                
                //add URL to URLArray
                [self.URLArray addObject:objects[i][@"eventURL"]];
                
                [moreInfoButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                
                //add allSubviews to view
                [view addSubview:imageView];
                [view addSubview:titleLabel];
                [view addSubview:dateLabel];
                [view addSubview:detailTextView];
                [view addSubview:moreInfoButton];
                view.backgroundColor = [UIColor whiteColor];
                
                //Add view to scrollView
                [self.scrollView addSubview:view];

            }
        } else {
            // Log details of the failure
            NSLog(@"Parse event query Error: %@ %@", error, [error userInfo]);
        }
    }];

}


-(void)buttonPressed: (id)sender
{
    UIButton *button =(UIButton *) sender;
    //透過button.tag 找到URLArray中對應的URL
    NSString *URL = [NSString stringWithFormat:@"%@", self.URLArray[button.tag]];
    
    
    EventDetailViewController *eventDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"eventDetailViewController"];
    
    //將EventDetailViewController中的eventDetailURL設為相對應的URL
    eventDetailVC.eventDetailURL=URL;
    
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
