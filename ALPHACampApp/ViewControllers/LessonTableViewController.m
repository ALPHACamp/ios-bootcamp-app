//
//  LessonTableViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/3/1.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "LessonTableViewController.h"
#import "ClassDetailViewController.h"

@interface LessonTableViewController ()<UITableViewDataSource,UITableViewDelegate>



@end

@implementation LessonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return  self.lessonArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = @"CodeTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor =[UIColor clearColor];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.font =[UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        //cell.textLabel.text =@"test";
        cell.textLabel.text= [NSString stringWithFormat:@"%@",self.lessonArray[indexPath.row][@"name"]];
        
    } else {
        //NSLog(@"I have been initialize. Row = %li", (long)indexPath.row);
    }

    return cell;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc]init];
    
    headerLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 40.0);
    headerLabel.textColor =[ UIColor blackColor];
    headerLabel.text = [NSString stringWithFormat:@"    %@",self.headerTitle];
    headerLabel.backgroundColor =[UIColor lightGrayColor];
    
    return headerLabel;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"tapped!");
    
    ClassDetailViewController *classDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"classDetailViewController"];
    classDetailVC.webViewURL=self.lessonArray[indexPath.row][@"url"];
    [self.navigationController pushViewController:classDetailVC animated:YES];
}


@end
