//
//  TweetsViewController.m
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"

@interface TweetsViewController() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpTableView];
    [self setUpRefreshControl];
    [self refresh];
}

- (void)setUpRefreshControl {
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)setUpNavigationBar {
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogoutTap:)];
    self.navigationItem.rightBarButtonItem = logoutButton;
}

- (void)setUpTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"tweet"];
}

- (void)refresh {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        [self.refreshControl endRefreshing];
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweet"];
    Tweet *tweet = self.tweets[indexPath.row];
    [cell setTweet:tweet];
    return cell;
}

- (IBAction)onLogoutTap:(id)sender {
    [User logout];
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
