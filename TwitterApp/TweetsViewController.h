//
//  TweetsViewController.h
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import <UIKit/UIKit.h>

enum TweetsViewControllerEndpoint : NSUInteger {
    TweetsViewControllerEndpointHome = 1,
    TweetsViewControllerEndpointMentions = 2
};

@interface TweetsViewController : UIViewController

@property (nonatomic, assign) enum TweetsViewControllerEndpoint endpoint;

@end
