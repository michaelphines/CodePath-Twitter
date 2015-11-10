//
//  LoginViewController.m
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "LoginViewController.h"
#import "TweetsViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()
- (IBAction)onLoginTap:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)onLoginTap:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            UIViewController *vc = [[TweetsViewController alloc] initWithNibName:@"TweetsViewController" bundle:nil];
            vc.navigationItem.hidesBackButton = YES;
            [self.navigationController pushViewController:vc animated:YES];
            NSLog(@"Logged in");
            NSLog(@"NVC: %@", self.navigationController);
        } else {
            // TODO: Present error
        }
        
    }];
}


@end
