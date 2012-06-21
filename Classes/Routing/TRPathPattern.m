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

- (id)initWith:(NSString*)pathPattern {
	self = [super init];
	pattern_ = pathPattern;
	return self;
}

- (NSDictionary*)match:(NSString*)requestPath {
	NSMutableDictionary* params = [NSMutableDictionary dictionary];
	NSArray* patternComponents = [pattern_ componentsSeparatedByString:@"/"];
	NSArray* pathComponents = [requestPath componentsSeparatedByString:@"/"];
	for (NSInteger i = 0; i < patternComponents.count; i++) {
		if (i >= pathComponents.count) return nil;
		NSString* patternComponent = [patternComponents objectAtIndex:i];
		NSString* pathComponent = [pathComponents objectAtIndex:i];
		if ([patternComponent hasPrefix:@":"]) {
			[params setObject:pathComponent forKey:[patternComponent substringFromIndex:1]];
		} else {
			if (![patternComponent isEqualToString:pathComponent]) return nil;
			
		}
	}
	return params;
}

@end
