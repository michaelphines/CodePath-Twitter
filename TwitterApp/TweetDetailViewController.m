//
//  TweetDetailViewController.m
//  TwitterApp
//
//  Created by Michael Hines on 11/10/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "ComposeViewController.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import <UIImageView+AFNetworking.h>
#import "NSDate+TimeAgo.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) Tweet *tweet;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.tweet != nil) {
        self.tweetLabel.text = self.tweet.text;
        self.handleLabel.text = [@"@" stringByAppendingString:self.tweet.user.handle];
        self.nameLabel.text = self.tweet.user.name;
        self.timestampLabel.text = [[self.tweet.createdAt timeAgo] lowercaseString];
        [self.profileImageView setImageWithURL:self.tweet.user.profileImageURL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
}

- (IBAction)retweetTapped:(id)sender {
    [[TwitterClient sharedInstance] retweet:self.tweet];
}

- (IBAction)favoriteTapped:(id)sender {
    [[TwitterClient sharedInstance] favorite:self.tweet];
}

- (IBAction)replyTapped:(id)sender {
    ComposeViewController *vc = [ComposeViewController new];
    [vc setParentTweet:self.tweet];
    [self.navigationController pushViewController:vc animated:YES];
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
