//
//  TRPathPattern.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TRPathPattern.h"

@implementation TRPathPattern

@synthesize pattern=pattern_;

+ (TRPathPattern*)newPathPattern:(NSString*)pathPattern {
	return [[TRPathPattern alloc] initWith:pathPattern];
}

- (BOOL)isEqual:(id)object {
	if (![object isKindOfClass:[TRPathPattern class]]) return NO;
	TRPathPattern* anotherPattern = object;
	return [[self pattern] isEqualToString:anotherPattern.pattern];
}

- (id)initWith:(NSString*)pathPattern {
	self = [super init];
	pattern_ = pathPattern;
	return self;
}

- (NSDictionary*)match:(NSString*)requestPath {
	NSMutableDictionary* params = [NSMutableDictionary dictionary];
	NSArray* patternComponents = [self trimEmptyComponents:[pattern_ componentsSeparatedByString:@"/"]];
	NSArray* pathComponents = [self trimEmptyComponents:[requestPath componentsSeparatedByString:@"/"]];
	if (patternComponents.count != pathComponents.count) return nil;
	for (NSInteger i = 0; i < patternComponents.count; i++) {
		NSString* patternComponent = [patternComponents objectAtIndex:i];
		NSString* pathComponent = [pathComponents objectAtIndex:i];
		if ([patternComponent hasPrefix:@":"]) {
			[params setObject:pathComponent forKey:[patternComponent substringFromIndex:1]];
		} else {
			if (![patternComponent isEqualToString:pathComponent]) {
				return nil;
			}
			
		}
	}
	return params;
}

@end

@implementation TRPathPattern (Private)

- (NSArray*)trimEmptyComponents:(NSArray*)components {
	NSMutableArray* result = [NSMutableArray array];
	for (NSString* component in components) {
		if (component && (![component isEqualToString:@""])) [result addObject:component];
	}
	return result;
}

@end