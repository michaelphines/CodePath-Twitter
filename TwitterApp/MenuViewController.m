//
//  MenuViewController.m
//  TwitterApp
//
//  Created by Michael Hines on 11/17/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "MenuViewController.h"
#import "TweetsViewController.h"
#import "ProfileViewController.h"
#import "User.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSArray *menuItems;
@property (strong, nonatomic) NSArray *viewControllers;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    [self.menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    ProfileViewController *profileViewController = [ProfileViewController new];
    TweetsViewController *tweetsViewController = [TweetsViewController new];
    TweetsViewController *mentionsViewController = [TweetsViewController new];
    
    mentionsViewController.endpoint = TweetsViewControllerEndpointMentions;
    
    self.viewControllers = @[profileViewController, tweetsViewController, mentionsViewController];
    self.menuItems = @[@"Profile", @"Tweets", @"Mentions"];
    
    self.hamburgerViewController.contentViewController = tweetsViewController;
        
    
    [self.menuTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.menuTableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.menuItems[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.menuTableView deselectRowAtIndexPath:indexPath animated:YES];
    self.hamburgerViewController.contentViewController = self.viewControllers[indexPath.row];
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
