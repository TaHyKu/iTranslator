//
//  IADataBaseManager.h
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IADataBaseManager : NSObject

+ (IADataBaseManager *)shared;

- (NSFetchedResultsController *)wordFetchedResultsControllerWith:(id<NSFetchedResultsControllerDelegate>)delegate;
- (IAWord *)addWordWith:(NSString *)original translation:(NSString *)translation;
- (void)updateWord:(IAWord *)word with:(NSString *)translation;
- (void)deleteAllWords;

@end
