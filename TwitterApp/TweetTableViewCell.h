//
//  TweetTableViewCell.h
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetTableViewCell : UITableViewCell

@property (strong, nonatomic) Tweet *tweet;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
