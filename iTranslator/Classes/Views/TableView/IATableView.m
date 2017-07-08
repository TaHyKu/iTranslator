//
//  IATableView.m
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IATableView.h"
#import "IAInputContainerView.h"

@interface IATableView () <IAInputContainerViewDelegate>

@property (nonatomic, strong) IAInputContainerView *inputContainerView;

@end

@implementation IATableView

#pragma mark - LifeCycle
+ (IATableView *)tableViewWith:(id<UITableViewDataSource>)dataSource
                      delegate:(id<IATableViewDelegate>)delegate
                     topOffset:(CGFloat)topOffset {
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.y = topOffset;
    frame.size.height -= topOffset;
    
    IATableView *tableView = [[IATableView alloc] initWithFrame:frame];
    tableView.dataSource = dataSource;
    tableView.delegate = delegate;
    
    return tableView;
}


#pragma mark - Override
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (UIView *)inputAccessoryView {
    if (_inputContainerView == nil) {
        _inputContainerView = [IAInputContainerView inputContainerViewWith:self];
    }
    
    return _inputContainerView;
}


#pragma mark - IAInputContainerViewDelegate
- (void)doneButtonPressedWith:(NSString *)text {
    [(id<IAInputContainerViewDelegate>)self.delegate doneButtonPressedWith:text];
}

- (void)inputContainerShoulBeginActive {
    [self setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 306.0f, 0.0f)];
}

- (void)inputContainerShoulBeginInactive {
    [self setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 50.0f, 0.0f)];
}

@end

