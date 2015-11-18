//
//  TweetsViewController.m
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetDetailViewController.h"
#import "ProfileViewController.h"
#import "ComposeViewController.h"
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.endpoint = TweetsViewControllerEndpointHome;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpTableView];
    [self setUpListeners];
    [self setUpRefreshControl];
    [self refresh];
}

- (void)setUpListeners {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onProfileTap:) name:@"profileTappedNotification" object:nil];
}

- (void)onProfileTap:(NSNotification *)notification {
    ProfileViewController *vc = [ProfileViewController new];
    vc.user = [[notification userInfo] valueForKey:@"user"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setUpRefreshControl {
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)setUpNavigationBar {
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogoutTap:)];
    UIBarButtonItem *composeButton = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeTap:)];
    self.navigationItem.leftBarButtonItem = logoutButton;
    self.navigationItem.rightBarButtonItem = composeButton;
}

- (void)setUpTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"tweet"];
}

- (void)refresh {
    if (self.endpoint == TweetsViewControllerEndpointMentions) {
        [[TwitterClient sharedInstance] mentionsWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            [self.refreshControl endRefreshing];
            self.tweets = tweets;
            [self.tableView reloadData];
        }];
    } else {
        [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            [self.refreshControl endRefreshing];
            self.tweets = tweets;
            [self.tableView reloadData];
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tweet"];
    Tweet *tweet = self.tweets[indexPath.row];
    cell.navigationController = [self navigationController];
    [cell setTweet:tweet];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetDetailViewController *vc = [TweetDetailViewController new];
    [vc setTweet:self.tweets[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onLogoutTap:(id)sender {
    [User logout];
}

- (IBAction)onComposeTap:(id)sender {
    [self.navigationController pushViewController:[ComposeViewController new] animated:YES];
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
