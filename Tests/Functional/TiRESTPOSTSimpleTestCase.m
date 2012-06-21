//
//  TiRESTPOSTSimpleTestCase.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TiRESTPOSTSimpleTestCase.h"
#import "TRSimplePOSTTestRouter.h"

@implementation TiRESTPOSTSimpleTestCase

- (Class)routerClass {
	return [TRSimplePOSTTestRouter class];
}

- (void)testPOSTRequestToRoot {
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/", TEST_ENDPOINT]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString* top = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	STAssertEqualObjects(top, @"POST /", @"Unexpected message");
}

- (void)testPOSTRequestToStoreAndGetValue {
	///Store value @"abcdefg" to server
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/set_value", TEST_ENDPOINT]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPBody:[@"abcdefg" dataUsingEncoding:NSUTF8StringEncoding]];
	[request setHTTPMethod:@"POST"];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString* result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSString* expected = @"stored value = abcdefg";
	
	STAssertEqualObjects(result, expected, @"Unexpected response");
	
	///Get value from server.
	url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/get_value", TEST_ENDPOINT]];
	request = [NSMutableURLRequest requestWithURL:url];
	
	responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	expected = @"abcdefg";
	STAssertEqualObjects(result, expected, @"Couldn't get stored value");
}

- (void)testPOSTRequestToEcho {
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/echo", TEST_ENDPOINT]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPBody:[@"Yahoo" dataUsingEncoding:NSUTF8StringEncoding]];
	[request setHTTPMethod:@"POST"];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString* result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSString* expected = @"Yahoo";
	
	STAssertEqualObjects(result, expected, @"Couldn't get echo value");
}

@end
