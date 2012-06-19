//
//  ubilocal_experimentTests.m
//  Tests
//
//  Created by Mizushima Kota on 12/06/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TRHTTPServerTests.h"

@implementation TRHTTPServerTests

- (void)setUp
{
    [super setUp];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)testTop
{
	NSURL* url = [NSURL URLWithString:@"http://scala.local:12345/"];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"GET"];
	NSURLResponse* response;
	NSError* error;
	NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if (error) {
		STFail(@"HTTP GET on %@ failed", url);
		return;
	}
	NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	NSLog(@"response = %@", responseString);
	
	STAssertTrue(YES, @"This assertion succeed");
}

@end
