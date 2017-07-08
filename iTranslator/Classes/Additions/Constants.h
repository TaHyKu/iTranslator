//
//  Constants.h
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

//Complect
typedef void(^dictionaryCompletion)(NSDictionary *dictionary);
typedef void(^errorCompletion)(NSError *error);


//Server
static NSString *const baseLink = @"https://translate.yandex.net";
static NSString *const apiKey = @"trnsl.1.1.20170706T223603Z.66d8fa170eeff224.54b5b4a1381900264c943139f68d36bcf110baa4";
static NSString *const languageDirection = @"ru-en";


//Request keys
static NSString *const apiKeyParameter   = @"key";
static NSString *const languageParameter = @"lang";
static NSString *const textParameter     = @"text";

//Response keys
static NSString *const codeKey           = @"code";
static NSString *const languageKey       = @"lang";
static NSString *const textKey           = @"text";

