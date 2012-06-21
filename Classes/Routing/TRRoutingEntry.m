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
