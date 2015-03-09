//
//  ClassViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "ClassViewController.h"
#import "LessonTableViewController.h"
#import <AFNetworking/AFNetworking.h>

#define api_key @"21f7814731bbbcc3302fbe06194e53c4993a3976"

@interface ClassViewController ()<UITableViewDataSource, UITableViewDelegate,
    UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *classTableView;
@property (strong, nonatomic)NSArray *courseArray;
@property (strong, nonatomic)NSArray *sectionArray;
@property (strong, nonatomic)NSString *headerTitle;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //set up first View load data
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *authToken = [NSString stringWithFormat:@"%@", [userDefaults stringForKey:@"auth_token"]];
    //NSLog(@"token: %@", authToken);
    NSDictionary *parameters = @{
                                 @"api_key": api_key,
                                 @"auth_token": authToken};
    
    [manager GET:@"https://dojo.alphacamp.co/api/v1/courses"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             self.courseArray = responseObject[@"courses"];
             AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
             
             self.headerTitle =[NSString stringWithFormat:@"%@", self.courseArray[1][@"name"]];
             NSString * course_id = [NSString stringWithFormat:@"%@", self.courseArray[1][@"id"]];
             NSString *sectionURL =[NSString stringWithFormat:@"https://dojo.alphacamp.co/api/v1/courses/%@",course_id];
             
             NSDictionary *parameters = @{
                                          @"api_key": api_key,
                                          @"auth_token": authToken};
             
             [manager GET:sectionURL
               parameters:parameters
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      //NSLog(@"Section: %@", responseObject);
                      self.sectionArray=responseObject[@"syllabus"];
                      [self.classTableView reloadData];
                      
                  }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Get Section Error: %@", error);
                  }];
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Get Course Error: %@", error);
         }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectCourseButton:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *authToken = [NSString stringWithFormat:@"%@", [userDefaults stringForKey:@"auth_token"]];
    NSDictionary *parameters = @{
                                 @"api_key": api_key,
                                 @"auth_token": authToken};
    
    [manager GET:@"https://dojo.alphacamp.co/api/v1/courses"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //NSLog(@"Course: %@", responseObject);
            self.courseArray = responseObject[@"courses"];
     
             // 用actionsheet 來選擇課程
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
             UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
             }];
             [alertController addAction:cancel];

              for (int i=0; i < self.courseArray.count; i++) {
                  UIAlertAction *action =[UIAlertAction actionWithTitle:self.courseArray[i][@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                      //抓取課程資料
                      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                      NSString * course_id = [NSString stringWithFormat:@"%@", self.courseArray[i][@"id"]];
                      NSString *sectionURL =[NSString stringWithFormat:@"https://dojo.alphacamp.co/api/v1/courses/%@",course_id];
                      
                      NSDictionary *parameters = @{
                                                   @"api_key": api_key,
                                                   @"auth_token": authToken};
                      
                      [manager GET:sectionURL
                        parameters:parameters
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               //NSLog(@"Section: %@", responseObject);
                               self.headerTitle =[NSString stringWithFormat:@"%@", self.courseArray[i][@"name"]];
                               self.sectionArray=responseObject[@"syllabus"];
                               [self.classTableView reloadData];
                               
                           }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               NSLog(@"Get Section Error: %@", error);
                           }];
                  }];
                [alertController addAction:action];
                  
              }
               [self presentViewController:alertController animated:YES completion:nil];
         }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Get Course Error: %@", error);
         }];
}


#pragma mark tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sectionArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc]init];
    
    headerLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 40.0);
    headerLabel.textColor =[ UIColor blackColor];
    if (self.headerTitle) {
        headerLabel.text = [NSString stringWithFormat:@"    %@",self.headerTitle];
    }
    
    headerLabel.backgroundColor =[UIColor lightGrayColor];

    return headerLabel;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CodeTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor =[UIColor clearColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font =[UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        
    } else {
        NSLog(@"I have been initialize. Row = %li", (long)indexPath.row);
    }
    cell.textLabel.text= [NSString stringWithFormat:@"%@",self.sectionArray[indexPath.row][@"section"][@"name"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    LessonTableViewController *lessonTVC= [self.storyboard instantiateViewControllerWithIdentifier:@"LessonTableViewController"];
    lessonTVC.headerTitle = [NSString stringWithFormat:@"%@",self.sectionArray[indexPath.row][@"section"][@"name"]];
    lessonTVC.lessonArray = self.sectionArray[indexPath.row][@"lessons"];
     [self.navigationController pushViewController:lessonTVC animated:YES];
}

@end
