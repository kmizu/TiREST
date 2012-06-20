//
//  TiRESTFunctionalTests.m
//  TiRESTFunctionalTests
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TiRESTFunctionalTests.h"
#import "TiREST.h"
#import "TRSimpleTestRouter.h"

@implementation TiRESTFunctionalTests {
	TRTiRESTServer* server_;
}

- (void)setUp {
    [super setUp];
	server_ = [TRTiRESTServer newServer:12345 routerClass:[TRSimpleTestRouter class]];
	
	[server_ start:nil];
}

- (void)tearDown {
	[server_ stop];
	server_ = nil;
    
    [super tearDown];
}

- (void)testSucceedAlways {
	STAssertTrue(YES, @"This test must succeed");
}

- (void)testSimpleGETRequest {
	NSURL* url = [NSURL URLWithString:@"http://localhost:12345/"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString* top = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	STAssertEqualObjects(top, @"<html><head><title>Hello, iPad</title></head><body><h1>Hello, iPad</h1>", @"Unexpected test result");
}

@end
