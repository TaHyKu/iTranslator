//
//  IAServerManager+Translation.m
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IAServerManager+Translation.h"
#import "IAServerManager.h"

static NSString *const translate = @"/api/v1.5/tr.json/translate";

@implementation IAServerManager (Translation)

- (void)translateWith:(NSString *)text success:(dictionaryCompletion)successBlock failure:(errorCompletion)failureBlock {
    NSDictionary *params = @{ languageParameter : languageDirection,
                              apiKeyParameter : apiKey,
                              textParameter : text };
    
    [self POST:translate parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *response = [NSDictionary responseDictionaryFrom:responseObject];
        if (successBlock != nil) { successBlock(response); }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock != nil) { failureBlock(error); }
    }];
}

@end

