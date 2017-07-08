//
//  IAServerManager.h
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IAServerManager : AFHTTPSessionManager

+ (IAServerManager *)shared;

- (void)cancelAllRequests;

@end
