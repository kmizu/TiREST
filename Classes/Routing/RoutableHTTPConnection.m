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

static const int httpLogLevel = HTTP_LOG_LEVEL_WARN;

@implementation RoutableHTTPConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path {
	HTTPLogTrace();
	if ([method isEqualToString:@"GET"]) return YES;
	if ([method isEqualToString:@"POST"]) return YES;
	if ([method isEqualToString:@"PUT"]) return YES;
	
	return NO;
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path {
	HTTPLogTrace();
	
	//TODO Implement this
	
	return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
	HTTPLogTrace();
	
	//TODO Immplement this
	
	/// This is just an example.
	NSString* hello = @"Hello";
	
	NSData* response = [hello dataUsingEncoding:NSUTF8StringEncoding];
	
	return [[HTTPDataResponse alloc] initWithData:response];
}

- (void)prepareForBodyWithSize:(UInt64)contentLength {
	HTTPLogTrace();
	
	//TODO implement this
}

- (void)processBodyData:(NSData *)postDataChunk {
	HTTPLogTrace();
	
	//TODO implement this
}

@end
