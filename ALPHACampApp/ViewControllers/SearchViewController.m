//
//  SearchViewController.m
//  ALPHACampApp
//
//  Created by PiHan Hsu on 2015/1/27.
//  Copyright (c) 2015年 PiHan Hsu. All rights reserved.
//

#import "SearchViewController.h"
#import "User.h"

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSArray * allPeople;
    NSArray * searchResults;
    
}

@property (strong, nonatomic) NSDictionary *user;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    User * user1 = [User new];
    user1.firstName =@"Bernard";
    user1.lastName = @"Chan";
    
    User * user2 = [User new];
    user2.firstName=@"Tim";
    user2.lastName=@"Du";
 
    User * user3 = [User new];
    user3.firstName=@"Ariel";
    user3.lastName=@"Chen";
    
    User * user4 = [User new];
    user4.firstName=@"Evelyn";
    user4.lastName=@"Chang";
    
    //allPeople = [NSArray arrayWithObjects:user1,user2,user3,user4, nil];
    
    //Literal Syntax
    allPeople =@[user1,user2,user3,user4];

}

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [allPeople count];
    }}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"searchResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    User *user = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        user = [searchResults objectAtIndex:indexPath.row];
    } else {
        user = [allPeople objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName];
    cell.textLabel.font =[UIFont systemFontOfSize:17];

    
    
    return cell;
}

#pragma mark -search filter
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(firstName contains[c] %@) OR (lastName contains[c] %@)", searchText, searchText];
    searchResults = [allPeople filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    UITabBarController *tabBarVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TabBarController"];
    [tabBarVC setSelectedIndex:2];
    [self presentViewController:tabBarVC animated:YES completion:nil];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

*/

@end
