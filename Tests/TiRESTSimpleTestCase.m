//
//  TiRESTSimpleTestCase.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TiRESTSimpleTestCase.h"

@implementation TiRESTSimpleTestCase

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
