//
//  TiRESTPUTSimpleTestCase.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TiRESTPUTSimpleTestCase.h"
#import "TRSimplePUTTestRouter.h"

@implementation TiRESTPUTSimpleTestCase

- (Class)routerClass {
	return [TRSimplePUTTestRouter class];
}

- (void)testPUTAndGETRequestToHello {
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hello.txt", TEST_ENDPOINT]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSString* helloWorld = @"Hello, World";
	[request setHTTPMethod:@"PUT"];
	[request setHTTPBody:[helloWorld dataUsingEncoding:NSUTF8StringEncoding]];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString* result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	STAssertEqualObjects(result, @"PUT /hello.txt", @"Unexpected message");
	
	
	request = [NSMutableURLRequest requestWithURL:url];
	responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	STAssertEqualObjects(result, @"Hello, World", @"Unexpected message");
}

@end
