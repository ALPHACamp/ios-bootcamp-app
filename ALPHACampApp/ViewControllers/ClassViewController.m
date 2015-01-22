//
//  ClassViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/14.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "ClassViewController.h"

@interface ClassViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *classTableView;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"CodeTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor =[UIColor clearColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font =[UIFont systemFontOfSize:17];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
       
        
    } else {
        //NSLog(@"I have been initialize. Row = %li", (long)indexPath.row);
    }
    cell.textLabel.text= [NSString stringWithFormat:@"Week%ld",(long)indexPath.row+1];
    
    
    
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
