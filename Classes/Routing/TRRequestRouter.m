//
//  RequestRouter.m
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HTTPConnection.h"
#import "TRRequestRouter.h"
#import "TRPathPattern.h"

@implementation TRRequestRouter {
	NSMutableArray* pathPatterns_;
	NSMutableArray* actions_;
	NSMutableArray* httpMethods_;
	__weak HTTPConnection* connection_;
}

@synthesize connection=connection_;

+ (TRRequestRouter*)newRequestRouter:(HTTPConnection*)connection {
	return [[TRRequestRouter alloc] initWithHTTPConnection:connection];
}

- (id)initWithHTTPConnection:(HTTPConnection*)connection {
	self = [super init];
	pathPatterns_ = [NSMutableArray array];
	actions_ = [NSMutableArray array];
	httpMethods_ = [NSMutableArray array];
	connection_ = connection;
	return self;
}

- (void)addRouteForGET:(NSString *)pathPattern to:(TRAction *)action {
	[self addRoute:pathPattern to:action method:@"GET"];
}

- (void)addRouteForPOST:(NSString *)pathPattern to:(TRAction *)action {
	[self addRoute:pathPattern to:action method:@"POST"];
}

- (void)addRouteForPUT:(NSString *)pathPattern to:(TRAction *)action {
	[self addRoute:pathPattern to:action method:@"PUT"];
}

- (void)addRoute:(NSString *)pathPattern to:(TRAction *)action method:(NSString *)httpMethod {
	[pathPatterns_ addObject:[TRPathPattern newPathPattern:pathPattern]];
	[actions_ addObject:action];
	[httpMethods_ addObject:httpMethod];
}

- (NSDictionary*)dispatchFor:(NSString*)httpMethod path:(NSString*)path body:(NSData*)body {
	NSString* pathWithoutQuery = path;
	NSRange found = [path rangeOfString:QUERY_DELIMITER];
	if (found.location != NSNotFound) {
		pathWithoutQuery = [path substringToIndex:found.location];
	}
	
	NSDictionary* params = [connection_ parseGetParams];
	
	for (NSInteger i = 0; i < pathPatterns_.count; i++) {
		TRPathPattern* pattern = [pathPatterns_ objectAtIndex:i];
		TRAction* action = [actions_ objectAtIndex:i];
		NSString* method = [httpMethods_ objectAtIndex:i];
		if ([pattern match:pathWithoutQuery] && [httpMethod isEqualToString:method]) {
			return [action process:params body:body];
		}
	}
	return [NSDictionary dictionaryWithObjectsAndKeys: @"404", @"status", @"404 Not Found", @"response", nil];
}

- (void)configure {
	assert(NO);
}

@end
