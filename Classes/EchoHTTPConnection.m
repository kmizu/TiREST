//
//  EchoHTTPConnection.m
//  
//
//  Created by Mizushima Kota on 12/06/13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EchoHTTPConnection.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "DDNumber.h"
#import "HTTPLogging.h"

static const int httpLogLevel = HTTP_LOG_LEVEL_WARN;

@implementation EchoHTTPConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path {
	HTTPLogTrace();
	
	if (![method isEqualToString:@"GET"]) return NO;
	if (![path hasPrefix:@"/"]) return NO;
	//先頭の/を取り除いた後に、/があるとダメなことにしておく(実際にはダメにしなくてもいいけど)
	if ([[path substringFromIndex:1] hasPrefix:@"/"]) return NO;
	
	return YES;
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path {
	HTTPLogTrace();
	
	return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
	HTTPLogTrace();
	
	NSString* echoMessage = [path substringFromIndex:1];
	
	NSString* echoJson = [NSString stringWithFormat:@"{\"type\":\"Echo\", \"message\":\"%@\"}", echoMessage];
	
	NSData* response = [echoJson dataUsingEncoding:NSUTF8StringEncoding];
	
	return [[HTTPDataResponse alloc] initWithData:response];
}

- (void)prepareForBodyWithSize:(UInt64)contentLength {
	HTTPLogTrace();
}

- (void)processBodyData:(NSData *)postDataChunk {
	HTTPLogTrace();
}

@end
