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
#import "TRRoutingTable.h"
#import "TRRoutingEntry.h"

@implementation TRRequestRouter {
	TRRoutingTable* table_;
	__weak HTTPConnection* connection_;
}

@synthesize connection=connection_;

+ (TRRequestRouter*)newRequestRouter:(HTTPConnection*)connection {
	return [[TRRequestRouter alloc] initWithHTTPConnection:connection];
}

- (id)initWithHTTPConnection:(HTTPConnection*)connection {
	self = [super init];
	table_ = [TRRoutingTable new];
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
	[table_ add:pathPattern to:action method:httpMethod];
}

- (NSDictionary*)dispatchFor:(NSString*)httpMethod path:(NSString*)path body:(NSData*)body {
	NSString* pathWithoutQuery = path;
	NSRange found = [path rangeOfString:QUERY_DELIMITER];
	if (found.location != NSNotFound) {
		pathWithoutQuery = [path substringToIndex:found.location];
	}
	
	NSDictionary* params = [connection_ parseGetParams];
	
	TRRoutingEntry* result = [table_ lookup:pathWithoutQuery method:httpMethod];
	if (result) {
		NSMutableDictionary* mapping = [NSMutableDictionary dictionary];
		[mapping addEntriesFromDictionary:params];
		[mapping addEntriesFromDictionary:result.params];
		return [result.action process:mapping body:body];
	}
	return [NSDictionary dictionaryWithObjectsAndKeys: @"404", @"status", @"404 Not Found", @"response", nil];
}

- (void)configure {
	assert(NO);
}

@end
