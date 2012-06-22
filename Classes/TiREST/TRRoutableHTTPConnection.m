//
//  RoutableHTTPConnection.m
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TRRoutableHTTPConnection.h"
#import "HTTPMessage.h"
#import "HTTPDataResponse.h"
#import "DDNumber.h"
#import "HTTPLogging.h"
#import "TRBlocksAction.h"
#import "TRHTTPResponse.h"

/// TODO
/// * Support "/:id/checkout" form pattern.
/// * Use __weak when using blocks

static const int httpLogLevel = HTTP_LOG_LEVEL_WARN;
static Class routerClass__;

@implementation TRRoutableHTTPConnection

@synthesize dataBody=dataBody_;
@synthesize router=router_;

+ (void)setRouterClass:(Class)routerClass {
	routerClass__ = routerClass;
}

+ (Class)routerClass {
	return routerClass__;
}

- (id)initWithAsyncSocket:(GCDAsyncSocket *)newSocket configuration:(HTTPConfig *)aConfig {
	self = [super initWithAsyncSocket:newSocket configuration:aConfig];
	router_ = (TRRequestRouter*)[[routerClass__ alloc] initWithHTTPConnection:self];
	[router_ configure];
	return self;
}

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path {
	HTTPLogTrace();
	
	if ([method isEqualToString:@"GET"]) return YES;
	if ([method isEqualToString:@"POST"]) return YES;
	if ([method isEqualToString:@"PUT"]) return YES;
	
	return NO;
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path {
	HTTPLogTrace();
	
	return [method isEqualToString:@"POST"] || [method isEqualToString:@"PUT"];
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
	HTTPLogTrace();
	
	NSDictionary* response = [router_ dispatchFor:method path:path body:dataBody_];
	NSNumber* statusCode = [response objectForKey:@"status"];
	NSObject* responseObject = [response objectForKey:@"response"];
	
	if (statusCode.integerValue != 200) {
		NSString* message = (NSString*)responseObject;
		return [[TRHTTPResponse alloc] initWithData:[message dataUsingEncoding:NSUTF8StringEncoding] status:statusCode.integerValue];
	}
	
	NSData* responseData;
	if ([responseObject isKindOfClass:[NSString class]]) {
		NSString* responseString = (NSString*)responseObject;
		responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
	} else if ([responseObject isKindOfClass:[NSDictionary class]]) {
		responseData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
	} else {
		responseData = (NSData*)responseObject;
	}
	
	return [[HTTPDataResponse alloc] initWithData:responseData];
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
