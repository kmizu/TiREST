//
//  RequestRouter.m
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RequestRouter.h"
#import "HTTPConnection.h"

@implementation RequestRouter {
	NSMutableArray* pathPatterns_;
	NSMutableArray* actions_;
	__weak HTTPConnection* connection_;
}

@synthesize connection=connection_;

+ (RequestRouter*)newRequestRouter:(HTTPConnection*)connection {
	return [[RequestRouter alloc] initWithHTTPConnection:connection];
}

- (id)initWithHTTPConnection:(HTTPConnection*)connection {
	self = [super init];
	pathPatterns_ = [NSMutableArray array];
	actions_ = [NSMutableArray array];
	connection_ = connection;
	return self;
}

- (void)addRoute:(NSString *)pathPattern to:(Action *)action {
	[pathPatterns_ addObject:pathPattern];
	[actions_ addObject:action];
}

- (NSData*)dispatchFor:(NSString*)httpMethod path:(NSString*)path body:(NSData*)body {
	NSLog(@"httpMethod = %@, path = %@", httpMethod, path);
	for (NSInteger i = 0; i < pathPatterns_.count; i++) {
		NSString* pattern = [pathPatterns_ objectAtIndex:i];
		Action* action = [actions_ objectAtIndex:i];
		// TODO Temporal implementation.
		NSDictionary* params;
		if ([httpMethod isEqualToString:@"GET"]) {
			params = [connection_ parseGetParams];
		} else if ([httpMethod isEqualToString:@"POST"]) {
			params = [connection_ parseParams:path];
		}
		if ([pattern hasPrefix:path]) {
			return [action process:params body:body];
		}
	}
}

@end
