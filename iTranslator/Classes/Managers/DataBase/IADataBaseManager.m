//
//  IADataBaseManager.m
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IADataBaseManager.h"
#import "IAWord.h"

@implementation IADataBaseManager

#pragma mark - LifeCycle
+ (IADataBaseManager *)shared {
    static IADataBaseManager *dataBaseManager = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        dataBaseManager = [[IADataBaseManager alloc] init];
    });
    
    return dataBaseManager;
}


#pragma mark - Interface
- (NSFetchedResultsController *)wordFetchedResultsControllerWith:(id<NSFetchedResultsControllerDelegate>)delegate {
    return [IAWord MR_fetchAllSortedBy:@"date" ascending:NO withPredicate:nil groupBy:nil delegate:delegate];
}

- (IAWord *)addWordWith:(NSString *)original translation:(NSString *)translation {
    IAWord *word = [IAWord MR_createEntity];
    word.original = original;
    word.date = [NSDate date];
    if (translation != nil) { word.translation = translation; }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    return word;
}

- (void)updateWord:(IAWord *)word with:(NSString *)translation {
    word.translation = translation;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)deleteAllWords {
    [IAWord MR_truncateAllInContext:[NSManagedObjectContext MR_defaultContext]];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
