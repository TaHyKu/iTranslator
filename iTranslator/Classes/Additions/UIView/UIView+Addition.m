//
//  UIView+Addition.m
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

+ (UIView *)horisontalBorderViewWith:(UIColor *)color height:(CGFloat)height {
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height = height;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    
    return view;
}

- (void)roundWith:(CGFloat)cornerRadius width:(CGFloat)borderWidht color:(UIColor*)borderColor {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidht;
    self.layer.borderColor = borderColor.CGColor;
}

@end
