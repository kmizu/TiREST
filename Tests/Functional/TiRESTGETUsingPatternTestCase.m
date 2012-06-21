//
//  TiRESTGETUsingPatternTestCase.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TiRESTGETUsingPatternTestCase.h"
#import "TRSimpleGETUsingPatternTestRouter.h"

@implementation TiRESTGETUsingPatternTestCase

- (Class)routerClass {
	return [TRSimpleGETUsingPatternTestRouter class];
}

- (void)testGETRequestToHelloYourName {
	NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/hello/Kota_Mizushima/", TEST_ENDPOINT]];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	NSURLResponse* response;
	NSError* error;
	
	NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	NSString* result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	STAssertEqualObjects(result, @"<html><head><title>Hello, Kota_Mizushima</title></head><body><h1>Hello, Kota_Mizushima</h1>", @"Unexpected HTML");
}

@end
