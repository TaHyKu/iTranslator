//
//  IAInputContainerView.m
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IAInputContainerView.h"

static CGFloat const height = 50.0f;
static CGSize const marginSize = {16.0f, 10.0f};
static CGSize const doneButtonSize = {60.0f, 30.0f};

@interface IAInputContainerView () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, weak) id<IAInputContainerViewDelegate> delegate;

@end


@implementation IAInputContainerView

#pragma mark - LifeCycle
+ (IAInputContainerView *)inputContainerViewWith:(id<IAInputContainerViewDelegate>)delegate {
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height = height;
    IAInputContainerView *view = [[IAInputContainerView alloc] initWithFrame:frame];
    [view initialSetup];
    view.delegate = delegate;
    
    return view;
}


#pragma mark - Setup
- (void)initialSetup {
    self.backgroundColor = [UIColor whiteColor];
    [self setupBorders];
    [self setupInputTextField];
    [self setupDoneButton];
}

- (void)setupBorders {
    UIView *topBorder = [UIView horisontalBorderViewWith:[UIColor lightBlue] height:1];
    UIView *bottomBorder = [UIView horisontalBorderViewWith:[UIColor lightBlue] height:1];
    CGRect frame = bottomBorder.frame;
    frame.origin.y = self.frame.size.height - 1;
    bottomBorder.frame = frame;
    
    [self addSubview:topBorder];
    [self addSubview:bottomBorder];
}

- (void)setupInputTextField {
    CGFloat width = self.frame.size.width - (3 * marginSize.width + doneButtonSize.width);
    CGFloat height = self.frame.size.height - 2 * marginSize.height;
    CGRect frame = CGRectMake(marginSize.width, marginSize.height, width, height);
    
    self.inputTextField = [[UITextField alloc] initWithFrame:frame];
    self.inputTextField.borderStyle = UITextBorderStyleNone;
    [self.inputTextField roundWith:5.0f width:1.0f color:[UIColor lightBlue]];
    self.inputTextField.placeholder = @"Input text";
    self.inputTextField.font = [UIFont systemFontOfSize:17.0f];
    self.inputTextField.textAlignment = NSTextAlignmentCenter;
    self.inputTextField.delegate = self;
    
    [self addSubview:self.inputTextField];
}

- (void)setupDoneButton {
    CGRect frame = CGRectMake(self.frame.size.width - (doneButtonSize.width + marginSize.width),
                              marginSize.height, doneButtonSize.width, doneButtonSize.height);
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.doneButton.frame = frame;
    [self.doneButton roundWith:5 width:0 color:[UIColor clearColor]];
    self.doneButton.backgroundColor = [UIColor lightBlue];
    [self.doneButton setTitle:@"Add" forState:UIControlStateNormal];
    self.doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [self.doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.doneButton];
}


#pragma mark - Action
- (void)doneAction:(id)sender {
    if (self.inputTextField.text.length == 0) { return; }
    
    [self.delegate doneButtonPressedWith:self.inputTextField.text];
    self.inputTextField.text = nil;
}


#pragma mark - UITexFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate inputContainerShoulBeginActive];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate inputContainerShoulBeginInactive];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length > 10) { return NO; }
    
    NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([string rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

@end

