//
//  IAWordsTableViewCell.m
//  iTranslator
//
//  Created by TaHyKu on 06.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IAWordsTableViewCell.h"

@interface IAWordsTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *originalLabel;
@property (nonatomic, weak) IBOutlet UILabel *translationLabel;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation IAWordsTableViewCell

#pragma mark - Interface
- (void)configureWith:(IAWord *)word {
    self.originalLabel.text = word.original;
    
    if (word.translation != nil) {
        self.translationLabel.hidden = NO;
        self.activityIndicatorView.hidden = YES;
        self.translationLabel.text = word.translation;
    } else {
        self.translationLabel.hidden = YES;
        self.activityIndicatorView.hidden = NO;
        [self.activityIndicatorView startAnimating];
    }
}

- (void)updateWith:(IAWord *)word {
    if (word.translation == nil) { return; }
    
    self.translationLabel.text = word.translation;
    self.translationLabel.hidden = NO;
    self.activityIndicatorView.hidden = YES;
}

@end

