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
	STAssertEqualObjects(result.pattern.pattern, @"/", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action1, nil);
	
	result = [table_ lookup:@"/" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action1, nil);
	
	result = [table_ lookup:@"/" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action1, nil);
	
	
	result = [table_ lookup:@"/a" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action2, nil);
	
	result = [table_ lookup:@"/a" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action2, nil);
	
	result = [table_ lookup:@"/a" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action2, nil);
	
	result = [table_ lookup:@"/a/b" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/b", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action3, nil);
	
	result = [table_ lookup:@"/a/b" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/b", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action3, nil);
	
	result = [table_ lookup:@"/a/b" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/b", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action3, nil);
	
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
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"100", nil);
	
	result = [table_ lookup:@"/200" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"200", nil);
	
	result = [table_ lookup:@"/300" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"300", nil);
	
	result = [table_ lookup:@"/a" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"a", nil);
	
	result = [table_ lookup:@"/a" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"a", nil);
	
	result = [table_ lookup:@"/a" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"a", nil);
	
	result = [table_ lookup:@"/a/b" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action3, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"b", nil);
	
	result = [table_ lookup:@"/a/b" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action3, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"b", nil);
	
	result = [table_ lookup:@"/a/b" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/a/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action3, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"b", nil);
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
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"100", nil);
	
	result = [table_ lookup:@"/200" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"200", nil);
	
	result = [table_ lookup:@"/300" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"300", nil);
	
	result = [table_ lookup:@"/a" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action2, nil);
	
	result = [table_ lookup:@"/a" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action2, nil);
	
	result = [table_ lookup:@"/a" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/a", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action2, nil);
}

- (void)testMultiParameterizedPatternMatch {
	TRAction* action1 = [TRAction new];
	
	[table_ add:@"/:id/:name" to:action1 method:@"GET"];
	[table_ add:@"/:id/:name" to:action1 method:@"POST"];
	[table_ add:@"/:id/:name" to:action1 method:@"PUT"];
	
	TRRoutingEntry* result;
	result = [table_ lookup:@"/100/foo" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"100", nil);
	STAssertEqualObjects([result.params objectForKey:@"name"], @"foo", nil);
	
	result = [table_ lookup:@"/200/bar" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"200", nil);
	STAssertEqualObjects([result.params objectForKey:@"name"], @"bar", nil);
	
	result = [table_ lookup:@"/300/baz" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"300", nil);
	STAssertEqualObjects([result.params objectForKey:@"name"], @"baz", nil);
}

- (void)testIgnoreCaseLastPatterhCharacterIsSlash {
	TRAction* action1 = [TRAction new];
	
	[table_ add:@"/:id/:name/" to:action1 method:@"GET"];
	[table_ add:@"/:id/:name/" to:action1 method:@"POST"];
	[table_ add:@"/:id/:name/" to:action1 method:@"PUT"];
	
	TRRoutingEntry* result;
	result = [table_ lookup:@"/100/foo" method:@"GET"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name/", nil);
	STAssertEqualObjects(result.httpMethod, @"GET", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"100", nil);
	STAssertEqualObjects([result.params objectForKey:@"name"], @"foo", nil);
	
	result = [table_ lookup:@"/200/bar" method:@"POST"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name/", nil);
	STAssertEqualObjects(result.httpMethod, @"POST", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"200", nil);
	STAssertEqualObjects([result.params objectForKey:@"name"], @"bar", nil);
	
	result = [table_ lookup:@"/300/baz" method:@"PUT"];
	STAssertEqualObjects(result.pattern.pattern, @"/:id/:name/", nil);
	STAssertEqualObjects(result.httpMethod, @"PUT", nil);
	STAssertEqualObjects(result.action, action1, nil);
	STAssertEqualObjects([result.params objectForKey:@"id"], @"300", nil);
	STAssertEqualObjects([result.params objectForKey:@"name"], @"baz", nil);
}

@end
