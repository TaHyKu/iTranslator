//
//  IAServerManager.m
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "IAServerManager.h"

@implementation IAServerManager

#pragma mark - LifeCycle
+ (IAServerManager *)shared {
    static IAServerManager *serverManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        serverManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseLink]];
    });
    
    return serverManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    if (self != nil) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    }
    
    return self;
}


#pragma mark - Interface
- (NSURL *)baseURL {
    return [NSURL URLWithString:baseLink];
}

- (void)cancelAllRequests {
    [self.session getAllTasksWithCompletionHandler:^(NSArray<__kindof NSURLSessionTask *> * _Nonnull tasks) {
        for (NSURLSessionTask *task in tasks) {
            [task cancel];
        }
    }];
}

@end

