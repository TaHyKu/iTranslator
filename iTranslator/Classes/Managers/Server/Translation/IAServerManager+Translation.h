//
//  IAServerManager+Translation.h
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IAServerManager.h"

@interface IAServerManager (Translation)

- (void)translateWith:(NSString *)text success:(dictionaryCompletion)successBlock failure:(errorCompletion)failureBlock;

@end
