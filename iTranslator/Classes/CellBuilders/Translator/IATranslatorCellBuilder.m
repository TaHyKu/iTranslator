//
//  IATranslatorCellBuilder.m
//  iTranslator
//
//  Created by TaHyKu on 06.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IATranslatorCellBuilder.h"

@interface IATranslatorCellBuilder ()

@property (nonatomic, strong) UITableView *tableView;

@end


@implementation IATranslatorCellBuilder

#pragma mark - LifeCycle
- (id)initWith:(UITableView *)tableView {
    self = [super init];
    
    if (self != nil) {
        self.tableView = tableView;
        [self initialSetup];
    }
    return self;
}


#pragma mark - Setup
- (void)initialSetup {
    [self.tableView registerNib:[UINib nibWithNibName:@"IAWordsTableViewCell" bundle:nil] forCellReuseIdentifier:@"IAWordsTableViewCell"];
}


#pragma mark - Interface
- (IAWordsTableViewCell *)cellWith:(IAWord *)word for:(NSIndexPath *)indexPath {
    IAWordsTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"IAWordsTableViewCell" forIndexPath:indexPath];
    [cell configureWith:word];
    
    return cell;
}

- (void)updateCellWith:(IAWord *)word for:(NSIndexPath *)indexPath {
    IAWordsTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell updateWith:word];
}

@end

