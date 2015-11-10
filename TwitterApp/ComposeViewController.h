//
//  ComposeViewController.h
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface ComposeViewController : UIViewController

- (void)setParentTweet:(Tweet *)parentTweet;

@end
