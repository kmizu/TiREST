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

- (id)initWithAsyncSocket:(GCDAsyncSocket *)newSocket configuration:(HTTPConfig *)aConfig {
	self = [super initWithAsyncSocket:newSocket configuration:aConfig];
	router_ = [RequestRouter newRequestRouter:self];
	
	[router_ addRoute:@"/" to:[BlocksAction newAction:^(Action* action, NSDictionary* params, NSData* body) {
		return [action successWithText:@"<html><head><title>Hello, iPad</title></head><body><h1>Hello, iPad</h1>"];
	}]];
	[router_ addRoute:@"/hello" to:[BlocksAction newAction:^(Action* action, NSDictionary* params, NSData* body) {
		return [action successWithJSON:[NSDictionary
										dictionaryWithObjectsAndKeys:@"Hello", @"message", nil]];
	}]];
	[router_ addRoute:@"/params" to:[BlocksAction newAction:^(Action* action, NSDictionary* params, NSData* body) {
		return [action successWithJSON:params];
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
	
	NSDictionary* response = [router_ dispatchFor:method path:path body:dataBody_];
	NSNumber* statusCode = [response objectForKey:@"status"];
	NSObject* responseObject = [response objectForKey:@"response"];
	
	if (statusCode.integerValue != 200) {
		//TODO kindful error
		return nil;
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
