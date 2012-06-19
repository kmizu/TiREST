//
//  RoutableHTTPConnection.m
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RoutableHTTPConnection.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "DDNumber.h"
#import "HTTPLogging.h"
#import "BlocksAction.h"

static const int httpLogLevel = HTTP_LOG_LEVEL_WARN;

@implementation RoutableHTTPConnection

@synthesize dataBody=dataBody_;
@synthesize router=router_;

- (NSUInteger)contentLength {
	return contentLength_;
}

- (id)initWithAsyncSocket:(GCDAsyncSocket *)newSocket configuration:(HTTPConfig *)aConfig {
	self = [super initWithAsyncSocket:newSocket configuration:aConfig];
	router_ = [RequestRouter newRequestRouter:self];
	
	[router_ addRoute:@"/" to:[BlocksAction newAction:^(NSDictionary* params, NSData* body) {
		return [@"<html><head><title>Hello, iPad</title></head><body><h1>Hello, iPad</h1>" dataUsingEncoding:NSUTF8StringEncoding];
	}]];
	return self;
}

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path {
	HTTPLogTrace();
	if ([method isEqualToString:@"GET"]) return YES;
	if ([method isEqualToString:@"POST"]) return YES;
	
	return NO;
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path {
	HTTPLogTrace();
	
	return [method isEqualToString:@"POST"];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
	HTTPLogTrace();
	
	NSData* response = [router_ dispatchFor:method path:path body:dataBody_];
	
	return [[HTTPDataResponse alloc] initWithData:response];
}

- (void)prepareForBodyWithSize:(UInt64)contentLength {
	HTTPLogTrace();
	
	contentLength_ = contentLength;
}

- (void)processBodyData:(NSData *)postDataChunk {
	HTTPLogTrace();
	
	dataBody_ = postDataChunk;
}

@end
