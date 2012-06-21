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

- (BOOL)match:(NSString*)requestPath {
	return [pattern_ hasPrefix:requestPath];
}

@end
