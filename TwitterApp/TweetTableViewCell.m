//
//  TweetTableViewCell.m
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "ProfileViewController.h"
#import <UIImageView+AFNetworking.h>
#import "NSDate+TimeAgo.h"

@interface TweetTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onProfileImageTap)];
    [self.profileImageView setUserInteractionEnabled:YES];
    [self.profileImageView addGestureRecognizer:tap];
}

- (IBAction)onProfileImageTap {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"profileTappedNotification" object: nil userInfo: @{@"user": self.tweet.user}];
}

- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.tweetLabel.text = tweet.text;
    self.handleLabel.text = [@"@" stringByAppendingString:tweet.user.handle];
    self.nameLabel.text = tweet.user.name;
    self.timestampLabel.text = [[tweet.createdAt timeAgo] lowercaseString];
    [self.profileImageView setImageWithURL:tweet.user.profileImageURL];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
