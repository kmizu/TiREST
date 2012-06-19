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

- (NSDictionary*)dispatchFor:(NSString*)httpMethod path:(NSString*)path body:(NSData*)body {
	NSString* pathWithoutQuery = path;
	NSRange found = [path rangeOfString:QUERY_DELIMITER];
	if (found.location != NSNotFound) {
		pathWithoutQuery = [path substringToIndex:found.location];
	}
	
	NSDictionary* params = [connection_ parseGetParams];
	
	for (NSInteger i = 0; i < pathPatterns_.count; i++) {
		NSString* pattern = [pathPatterns_ objectAtIndex:i];
		Action* action = [actions_ objectAtIndex:i];
		// TODO support richer pattern
		if ([pattern hasPrefix:pathWithoutQuery]) {
			return [action process:params body:body];
		}
	}
	return nil;
}

@end
