//
//  IATableView.h
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IATableViewDelegate <UITableViewDelegate>

- (void)doneButtonPressedWith:(NSString *)inputText;

@end

@interface IATableView : UITableView

+ (IATableView *)tableViewWith:(id<UITableViewDataSource>)dataSource
                      delegate:(id<IATableViewDelegate>)delegate
                     topOffset:(CGFloat)topOffset;

@end
