//
//  NSDictionary+Addition.m
//  iTranslator
//
//  Created by TaHyKu on 07.07.17.
//  Copyright © 2017 TaHyKu. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)

+ (NSDictionary *)responseDictionaryFrom:(id)responseObject {
    return [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
}

@end
