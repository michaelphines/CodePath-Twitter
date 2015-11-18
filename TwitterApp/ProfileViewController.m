//
//  ProfileViewController.m
//  TwitterApp
//
//  Created by Michael Hines on 11/17/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.user == nil) {
        self.user = [User currentUser];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUser:(User *)user {
    NSLog(@"Setting user");
    _user = user;
    
    [self.profileImageView setImageWithURL:user.profileImageURL];
    self.usernameLabel.text = [@"@" stringByAppendingString:user.handle];
    self.realNameLabel.text = user.name;
    self.tweetsLabel.text = [NSString stringWithFormat:@"%@ tweets", user.tweetCount];
    self.followingLabel.text = [NSString stringWithFormat:@"%@ following", user.followingCount];
    self.followersLabel.text = [NSString stringWithFormat:@"%@ followers", user.followerCount];
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
