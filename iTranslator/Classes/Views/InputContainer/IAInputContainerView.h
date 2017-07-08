//
//  IAInputContainerView.h
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IAInputContainerView;

@protocol IAInputContainerViewDelegate <NSObject>

- (void)doneButtonPressedWith:(NSString *)text;
- (void)inputContainerShoulBeginActive;
- (void)inputContainerShoulBeginInactive;

@end

@interface IAInputContainerView : UIView

+ (IAInputContainerView *)inputContainerViewWith:(id<IAInputContainerViewDelegate>)delegate;

@end
