//
//  TiRESTSimpleTestCase.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TiRESTGETSimpleTestCase.h"
#import "TRSimpleGETTestRouter.h"

@implementation TiRESTGETSimpleTestCase

- (Class)routerClass {
	return [TRSimpleGETTestRouter class];
}

- (void)testGETRequestToRoot {
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/", TEST_ENDPOINT]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString* top = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	STAssertEqualObjects(top, @"<html><head><title>Hello, TiREST</title></head><body><h1>Hello, TiREST</h1>", @"Unexpected HTML");
}

- (void)testGETRequestToJSON {
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/json_hello", TEST_ENDPOINT]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSDictionary* result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
	NSDictionary* expected = [NSDictionary dictionaryWithObjectsAndKeys: @"Hello", @"message",nil];
	
	STAssertEqualObjects(result, expected, @"Unexpected JSON");
}

- (void)testGETRequestToParams {
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/params?x=100&y=200&z=300", TEST_ENDPOINT]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSDictionary* result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
	NSDictionary* expected = [NSDictionary dictionaryWithObjectsAndKeys: @"100", @"x", @"200", @"y", @"300", @"z", nil];
	
	STAssertEqualObjects(result, expected, @"Query paramters was not parsed correctly");
}


@end
