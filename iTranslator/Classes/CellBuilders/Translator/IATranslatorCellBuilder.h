//
//  IATranslatorCellBuilder.h
//  iTranslator
//
//  Created by TaHyKu on 06.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//


#import "IAWordsTableViewCell.h"

@class IAWord;

@interface IATranslatorCellBuilder : NSObject

- (id)initWith:(UITableView *)tableView;
- (IAWordsTableViewCell *)cellWith:(IAWord *)word for:(NSIndexPath *)indexPath;
- (void)updateCellWith:(IAWord *)word for:(NSIndexPath *)indexPath;

@end
