//
//  TiRESTTRRoutingTableTestCase.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TiRESTTRRoutingTableTestCase.h"
#import <TiREST/TiREST.h>

@implementation TiRESTTRRoutingTableTestCase {
	TRRoutingTable* table_;
}

- (void)setUp {
	table_ = [TRRoutingTable new];
	[super setUp];
}

- (void)tearDown {
	table_ = nil;
	[super tearDown];
}

- (void)testSimplePatternIsValid {
	TRAction* action1 = [TRAction new];
	TRAction* action2 = [TRAction new];
	TRAction* action3 = [TRAction new];
	
	[table_ add:@"/" to:action1 method:@"GET"];
	[table_ add:@"/" to:action1 method:@"POST"];
	[table_ add:@"/" to:action1 method:@"PUT"];
	
	[table_ add:@"/a" to:action2 method:@"GET"];
	[table_ add:@"/a" to:action2 method:@"POST"];
	[table_ add:@"/a" to:action2 method:@"PUT"];
	
	[table_ add:@"/a/b" to:action3 method:@"GET"];
	[table_ add:@"/a/b" to:action3 method:@"POST"];
	[table_ add:@"/a/b" to:action3 method:@"PUT"];
	
	TRRoutingEntry* result;
	result = [table_ lookup:@"/" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	
	result = [table_ lookup:@"/" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	
	result = [table_ lookup:@"/" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	
	
	result = [table_ lookup:@"/a" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action2, @"Unexpected match result");
	
	result = [table_ lookup:@"/a" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action2, @"Unexpected match result");
	
	result = [table_ lookup:@"/a" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action2, @"Unexpected match result");
	
	result = [table_ lookup:@"/a/b" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/b", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action3, @"Unexpected match result");
	
	result = [table_ lookup:@"/a/b" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/b", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action3, @"Unexpected match result");
	
	result = [table_ lookup:@"/a/b" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/b", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action3, @"Unexpected match result");
	
}

- (void)testPatternMatchIsOrdered1 {
	TRAction* action1 = [TRAction new];
	TRAction* action2 = [TRAction new];
	TRAction* action3 = [TRAction new];
	
	[table_ add:@"/:id" to:action1 method:@"GET"];
	[table_ add:@"/:id" to:action1 method:@"POST"];
	[table_ add:@"/:id" to:action1 method:@"PUT"];
	
	[table_ add:@"/a" to:action2 method:@"GET"];
	[table_ add:@"/a" to:action2 method:@"POST"];
	[table_ add:@"/a" to:action2 method:@"PUT"];
	
	[table_ add:@"/a/:id" to:action3 method:@"GET"];
	[table_ add:@"/a/:id" to:action3 method:@"POST"];
	[table_ add:@"/a/:id" to:action3 method:@"PUT"];
	
	TRRoutingEntry* result;
	result = [table_ lookup:@"/100" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"100", @"Unexpected match result");
	
	result = [table_ lookup:@"/200" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"200", @"Unexpected match result");
	
	result = [table_ lookup:@"/300" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"300", @"Unexpected match result");
	
	result = [table_ lookup:@"/a" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"a", @"Unexpected match result");
	
	result = [table_ lookup:@"/a" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"a", @"Unexpected match result");
	
	result = [table_ lookup:@"/a" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"a", @"Unexpected match result");
	
	result = [table_ lookup:@"/a/b" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action3, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"b", @"Unexpected match result");
	
	result = [table_ lookup:@"/a/b" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action3, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"b", @"Unexpected match result");
	
	result = [table_ lookup:@"/a/b" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action3, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"b", @"Unexpected match result");
}

- (void)testPatternMatchIsOrdered2 {
	TRAction* action1 = [TRAction new];
	TRAction* action2 = [TRAction new];
	
	[table_ add:@"/a" to:action2 method:@"GET"];
	[table_ add:@"/a" to:action2 method:@"POST"];
	[table_ add:@"/a" to:action2 method:@"PUT"];
	
	[table_ add:@"/:id" to:action1 method:@"GET"];
	[table_ add:@"/:id" to:action1 method:@"POST"];
	[table_ add:@"/:id" to:action1 method:@"PUT"];
	
	TRRoutingEntry* result;
	result = [table_ lookup:@"/100" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"100", @"Unexpected match result");
	
	result = [table_ lookup:@"/200" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"200", @"Unexpected match result");
	
	result = [table_ lookup:@"/300" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"300", @"Unexpected match result");
	
	result = [table_ lookup:@"/a" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action2, @"Unexpected match result");
	
	result = [table_ lookup:@"/a" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action2, @"Unexpected match result");
	
	result = [table_ lookup:@"/a" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action2, @"Unexpected match result");
}

- (void)testMultiParameterizedPatternMatch {
	TRAction* action1 = [TRAction new];
	
	[table_ add:@"/:id/:name" to:action1 method:@"GET"];
	[table_ add:@"/:id/:name" to:action1 method:@"POST"];
	[table_ add:@"/:id/:name" to:action1 method:@"PUT"];
	
	TRRoutingEntry* result;
	result = [table_ lookup:@"/100/foo" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"100", @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"name"], @"foo", @"Unexpected match result");
	
	result = [table_ lookup:@"/200/bar" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"200", @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"name"], @"bar", @"Unexpected match result");
	
	result = [table_ lookup:@"/300/baz" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"300", @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"name"], @"baz", @"Unexpected match result");
}

- (void)testIgnoreCaseLastPatterhCharacterIsSlash {
	TRAction* action1 = [TRAction new];
	
	[table_ add:@"/:id/:name/" to:action1 method:@"GET"];
	[table_ add:@"/:id/:name/" to:action1 method:@"POST"];
	[table_ add:@"/:id/:name/" to:action1 method:@"PUT"];
	
	TRRoutingEntry* result;
	result = [table_ lookup:@"/100/foo" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name/", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"GET", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"100", @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"name"], @"foo", @"Unexpected match result");
	
	result = [table_ lookup:@"/200/bar" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name/", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"POST", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"200", @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"name"], @"bar", @"Unexpected match result");
	
	result = [table_ lookup:@"/300/baz" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name/", @"Unexpected match result");
	STAssertEqualObjects(result.httpMethod, @"PUT", @"Unexpected match result");
	STAssertEqualObjects(result.action, action1, @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"id"], @"300", @"Unexpected match result");
	STAssertEqualObjects([result.params objectForKey:@"name"], @"baz", @"Unexpected match result");
}

@end
