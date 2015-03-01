//
//  ClassViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "ClassViewController.h"
#import <AFNetworking/AFNetworking.h>

#define api_key @"21f7814731bbbcc3302fbe06194e53c4993a3976"

@interface ClassViewController ()<UITableViewDataSource, UITableViewDelegate,
    UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *classTableView;
@property (strong, nonatomic)NSArray *courseArray;
@property (strong, nonatomic)NSArray *sectionArray;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    NSLog(@"token: %@", authToken);
    NSDictionary *parameters = @{
                                 @"api_key": api_key,
                                 @"auth_token": authToken};
    
    [manager GET:@"https://school.alphacamp.co/api/v1/courses"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //NSLog(@"Course: %@", responseObject);
            self.courseArray = responseObject[@"courses"];
     
             // 用actionsheet 來選擇課程
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
              for (int i=0; i < self.courseArray.count; i++) {
                  UIAlertAction *action =[UIAlertAction actionWithTitle:self.courseArray[i][@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                      NSLog(@"button pressed: %i", i);
                      //抓取課程資料
                      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                      NSString * course_id = [NSString stringWithFormat:@"%@", self.courseArray[i][@"id"]];
                      NSString *sectionURL =[NSString stringWithFormat:@"https://school.alphacamp.co/api/v1/courses/%@",course_id];
                      
                      NSDictionary *parameters = @{
                                                   @"api_key": api_key,
                                                   @"auth_token": authToken};
                      
                      [manager GET:sectionURL
                        parameters:parameters
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               //NSLog(@"Section: %@", responseObject);
                               self.sectionArray=responseObject[@"syllabus"];
                               NSLog(@"syllabus: %lu", self.sectionArray.count);
                               for (int i =0; i<self.sectionArray.count; i++) {
                                   NSLog(@"section:%@", self.sectionArray[i][@"section"][@"name"]);
                               }
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
    if (!self.sectionArray.count) {
        return 3;
    }else
    return self.sectionArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc]init];
    
    headerLabel.frame = CGRectMake(0, 0, 300, 40.0);
    headerLabel.textColor =[ UIColor grayColor];
    headerLabel.text = @"    課程內容";
    //headerLabel.backgroundColor =[UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1];

    return headerLabel;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
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
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
       
        
    } else {
        //NSLog(@"I have been initialize. Row = %li", (long)indexPath.row);
    }
    if (!self.sectionArray) {
        cell.textLabel.text=@"";
    }else{
    cell.textLabel.text= [NSString stringWithFormat:@"%@",self.sectionArray[indexPath.row][@"section"][@"name"]];
    //cell.detailTextLabel.text= @"test";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tapped!");
    
    UIViewController *classDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"classDetailViewController"];
    
    [self.navigationController pushViewController:classDetailVC animated:YES];

   
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
