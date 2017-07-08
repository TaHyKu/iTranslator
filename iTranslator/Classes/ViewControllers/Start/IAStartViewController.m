//
//  IAStartViewController.m
//  iTranslator
//
//  Created by TaHyKu on 08.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IAStartViewController.h"

@interface IAStartViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;

@end

@implementation IAStartViewController

#pragma mark - LifeCycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self startLogoAnimation];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - Navigation
- (void)proceedToTranslator {
    IATranslatorViewController *translator = [self.storyboard instantiateViewControllerWithIdentifier:@"IATranslatorViewController"];
    [self.navigationController pushViewController:translator animated:NO];
}

#pragma mark - Animation
- (void)startLogoAnimation {
    [self performSelector:@selector(zoomOutAnimation) withObject:nil afterDelay:1.0];
}

- (void)zoomOutAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        self.logoImageView.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [self zoomInAnimation];
    }];
}

- (void)zoomInAnimation {
    [UIView animateWithDuration:0.55 animations:^{
        self.logoImageView.transform = CGAffineTransformMakeScale(32, 32);
    } completion:^(BOOL finished) {
        [self proceedToTranslator];
    }];
}

@end

