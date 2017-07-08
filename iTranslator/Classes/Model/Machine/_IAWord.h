// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IAWord.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface IAWordID : NSManagedObjectID {}
@end

@interface _IAWord : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) IAWordID *objectID;

@property (nonatomic, strong, nullable) NSDate* date;

@property (nonatomic, strong, nullable) NSString* original;

@property (nonatomic, strong, nullable) NSString* translation;

@end

@interface _IAWord (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSDate*)primitiveDate;
- (void)setPrimitiveDate:(nullable NSDate*)value;

- (nullable NSString*)primitiveOriginal;
- (void)setPrimitiveOriginal:(nullable NSString*)value;

- (nullable NSString*)primitiveTranslation;
- (void)setPrimitiveTranslation:(nullable NSString*)value;

@end

@interface IAWordAttributes: NSObject 
+ (NSString *)date;
+ (NSString *)original;
+ (NSString *)translation;
@end

NS_ASSUME_NONNULL_END
