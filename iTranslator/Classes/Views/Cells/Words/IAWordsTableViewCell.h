//
//  IAWordsTableViewCell.h
//  iTranslator
//
//  Created by TaHyKu on 06.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IAWord;

@interface IAWordsTableViewCell : UITableViewCell

- (void)configureWith:(IAWord *)word;
- (void)updateWith:(IAWord *)word;

@end
