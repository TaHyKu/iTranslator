// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to IAWord.m instead.

#import "_IAWord.h"

@implementation IAWordID
@end

@implementation _IAWord

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Word" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Word";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Word" inManagedObjectContext:moc_];
}

- (IAWordID*)objectID {
	return (IAWordID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic date;

@dynamic original;

@dynamic translation;

@end

@implementation IAWordAttributes 
+ (NSString *)date {
	return @"date";
}
+ (NSString *)original {
	return @"original";
}
+ (NSString *)translation {
	return @"translation";
}
@end

