//
//  UIView+Addition.h
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addition)

+ (UIView *)horisontalBorderViewWith:(UIColor *)color height:(CGFloat)height;

- (void)roundWith:(CGFloat)cornerRadius width:(CGFloat)borderWidht color:(UIColor*)borderColor;

@end
