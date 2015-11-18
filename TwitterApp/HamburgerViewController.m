//
//  HamburgerViewController.m
//  TwitterApp
//
//  Created by Michael Hines on 11/17/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "HamburgerViewController.h"

@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic) CGFloat originalLeftMargin;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMenuViewController:(UIViewController *)menuViewController {
    [self.view layoutIfNeeded];
    
    if (_menuViewController != nil) {
        [_menuViewController willMoveToParentViewController:nil];
        [_menuViewController removeFromParentViewController];
        [_menuViewController didMoveToParentViewController:nil];
    }
    _menuViewController = menuViewController;
    
    [_menuViewController willMoveToParentViewController:self];
    [self.menuView addSubview:menuViewController.view];
    [_menuViewController didMoveToParentViewController:self];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    [self.view layoutIfNeeded];
    
    if (_contentViewController != nil) {
        [_contentViewController willMoveToParentViewController:nil];
        [_contentViewController removeFromParentViewController];
        [_contentViewController didMoveToParentViewController:nil];
    }
    
    _contentViewController = contentViewController;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:contentViewController];
    nvc.view.frame = self.view.frame;
    
    [nvc willMoveToParentViewController:self];
    [self.contentView addSubview:nvc.view];
    [nvc didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    if ([sender state] == UIGestureRecognizerStateBegan) {
        self.originalLeftMargin = self.leftMarginConstraint.constant;
    } else if ([sender state] == UIGestureRecognizerStateChanged) {
        self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x;
    } else if ([sender state] == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            if (velocity.x > 0) {
                self.leftMarginConstraint.constant = self.view.frame.size.width - 50;
            } else {
                self.leftMarginConstraint.constant = 0;
            }
            [self.view layoutIfNeeded];
        }];
    }
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
