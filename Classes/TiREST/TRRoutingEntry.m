//
//  TRRoutingResult.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TRRoutingEntry.h"
#import "TRAction.h"
#import "TRPathPattern.h"

@implementation TRRoutingEntry {
	TRPathPattern* pattern_;
	TRAction* action_;
	NSString* httpMethod_;
	NSDictionary* params_;
}

@synthesize pattern=pattern_;
@synthesize action=action_;
@synthesize httpMethod=httpMethod_;
@synthesize params=params_;

- (BOOL)isEqual:(id)object {
	if (![object isKindOfClass:[TRRoutingEntry class]]) return NO;
	TRRoutingEntry* anotherObject = object;
	
	if (!pattern_) {
		if (!anotherObject.pattern) return NO;
	} else {
		if (![pattern_ isEqual:anotherObject.pattern]) return NO;
	}
	
	if (!action_) {
		if (!anotherObject.action) return NO;
	} else {
		if (![action_ isEqual:anotherObject.action]) return NO;
	}
	
	if (!httpMethod_) {
		if (!anotherObject.httpMethod) return NO;
	} else {
		if (![httpMethod_ isEqual:anotherObject.httpMethod]) return NO;
	}
	
	if (!params_) {
		if (!anotherObject.params) return NO;
	} else {
		if (![params_ isEqual:anotherObject.params]) return NO;
	}
	
	return YES;
}

- (NSString*)description {
	return [NSString stringWithFormat:@"TRRoutingEntry(pattern=%@, action=%@, httpMethod=%@, params=%@)", pattern_, action_, httpMethod_, params_];
}

- (id)init:(TRPathPattern*)pattern action:(TRAction*)action httpMethod:(NSString*)httpMethod params:(NSDictionary*)params {
	self = [super init];
	pattern_ = pattern;
	action_ = action;
	httpMethod_ = httpMethod;
	params_ = params;
	return self;
}

+ (TRRoutingEntry*)newEntry:(TRPathPattern*)pattern action:(TRAction*)action httpMethod:(NSString*)httpMethod {
	return [[TRRoutingEntry alloc] init:pattern action:action httpMethod:httpMethod params:nil];
}

+ (TRRoutingEntry*)newEntry:(TRPathPattern*)pattern action:(TRAction*)action httpMethod:(NSString*)httpMethod params:(NSDictionary*)params {
	return [[TRRoutingEntry alloc] init:pattern action:action httpMethod:httpMethod params:params];
}

@end
