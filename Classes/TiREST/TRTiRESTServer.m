//
//  TiRESTServer.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TRTiRESTServer.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@implementation TRTiRESTServer {
	HTTPServer* httpServer_;
}

@synthesize routerClass=routerClass_;

- (id)init:(NSUInteger)port useBonjour:(BOOL)useBonjour documentRoot:(NSString*)documentRoot routerClass:(Class)routerClass {
	self = [self init];
	
	httpServer_ = [[HTTPServer alloc] init];
	[httpServer_ setPort:port];
	if (useBonjour) [httpServer_ setType:@"_http._tcp."];
	NSString* webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:documentRoot];
	[httpServer_ setDocumentRoot:webPath];
	routerClass_ = routerClass;
	
	///Note: Ordering of two statments is important in the following two statement.
	[TRRoutableHTTPConnection setRouterClass:routerClass_];
	[httpServer_ setConnectionClass:[TRRoutableHTTPConnection class]];
	
	return self;
}

- (id)init:(NSUInteger)port routerClass:(Class)routerClass {
	return [self init:port useBonjour:YES documentRoot:@"Web" routerClass:routerClass];
}

- (BOOL)start:(NSError *__autoreleasing *)error {
	return [httpServer_ start:error];
}

- (void)stop {
	[httpServer_ stop];
}

+ (TRTiRESTServer*)newServer:(NSUInteger)port useBonjour:(BOOL)useBonjour documentRoot:(NSString*)documentRoot routerClass:(Class)routerClass {
	return [[TRTiRESTServer alloc] init:port useBonjour:useBonjour documentRoot:documentRoot routerClass:routerClass];
}

+ (TRTiRESTServer*)newServer:(NSUInteger)port routerClass:(Class)routerClass {
	return [[TRTiRESTServer alloc] init:port routerClass:routerClass];
}

@end
