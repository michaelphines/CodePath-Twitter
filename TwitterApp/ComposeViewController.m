//
//  ComposeViewController.m
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (strong, nonatomic) Tweet *parentTweet;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Compose";
    [self.composeTextView becomeFirstResponder];
    UIBarButtonItem *tweetButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweetTap:)];
    if (self.parentTweet != nil) {
        self.composeTextView.text = [NSString stringWithFormat:@"@%@ ", self.parentTweet.user.handle];
    }
    self.navigationItem.rightBarButtonItem = tweetButton;
}

- (IBAction)onTweetTap:(id)sender {
    NSString *tweet = self.composeTextView.text;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[TwitterClient sharedInstance] postTweet:tweet parent:self.parentTweet completion:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error == nil) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    // TODO: display error
                }
            });
        }];
    });
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
