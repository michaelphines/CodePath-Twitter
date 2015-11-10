//
//  TweetTableViewCell.m
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "TweetTableViewCell.h"

@interface TweetTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setTweetText:(NSString *)tweetText {
    NSLog(@"Setting tweet text");
    self.tweetLabel.text = tweetText;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
