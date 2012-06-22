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

- (void)testPatternMatchingCaseOnlySimplePattern {
	TRAction* action1 = [TRAction new];
	TRAction* action2 = [TRAction new];
	TRAction* action3 = [TRAction new];
	
	[table_ add:@"/" to:action1 method:@"GET"];
	[table_ add:@"/a" to:action2 method:@"GET"];
	[table_ add:@"/a/b" to:action3 method:@"GET"];
	
	TRRoutingEntry* result;
	TRRoutingEntry* expected;
	
	result = [table_ lookup:@"/" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/a" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/a"] action:action2 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/a/b" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/a/b"] action:action3 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
}

- (void)testPatternMatchingCaseFailure {
	TRAction* action = [TRAction new];
	
	[table_ add:@"/" to:action method:@"GET"];
	
	TRRoutingEntry* result;
	TRRoutingEntry* expected;
	
	result = [table_ lookup:@"/" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/"] action:action httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/" method:@"POST"];
	expected = nil;
	STAssertEqualObjects(result, expected, @"lookup for unregistered HTTP method 'POST' should return nil");
	
	result = [table_ lookup:@"/foo" method:@"GET"];
	expected = nil;
	STAssertEqualObjects(result, expected, @"lookup for unregisterd pattern should return nil");
}

- (void)testPatternMatchingCaseMultipleHTTPMethodIsRegistered {
	TRAction* action1 = [TRAction new];
	TRAction* action2 = [TRAction new];
	TRAction* action3 = [TRAction new];
	
	[table_ add:@"/" to:action1 method:@"GET"];
	[table_ add:@"/" to:action2 method:@"POST"];
	[table_ add:@"/" to:action3 method:@"PUT"];
	
	TRRoutingEntry* result;
	TRRoutingEntry* expected;
	
	result = [table_ lookup:@"/" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/" method:@"POST"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/"] action:action2 httpMethod:@"POST" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/" method:@"PUT"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/"] action:action3 httpMethod:@"PUT" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
}

- (void)testPatternMatchingCaseVariablePatternIsPrecedent {
	TRAction* action1 = [TRAction new];
	TRAction* action2 = [TRAction new];
	
	[table_ add:@"/:id" to:action1 method:@"GET"];
	[table_ add:@"/a" to:action2 method:@"GET"];
	
	TRRoutingEntry* result;
	TRRoutingEntry* expected;
	
	result = [table_ lookup:@"/100" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionaryWithObject:@"100" forKey:@"id"]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/a" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionaryWithObject:@"a" forKey:@"id"]];
	STAssertEqualObjects(result, expected, nil);
}

- (void)testPatternMatchingCaseLiteralPatternIsPrecedent {
	TRAction* action1 = [TRAction new];
	TRAction* action2 = [TRAction new];
	
	[table_ add:@"/a" to:action2 method:@"GET"];
	[table_ add:@"/:id" to:action1 method:@"GET"];
	
	TRRoutingEntry* result;
	TRRoutingEntry* expected;
	result = [table_ lookup:@"/100" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionaryWithObject:@"100" forKey:@"id"]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/a" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/a"] action:action2 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
}

- (void)testPatternMatchingCaseMultiVariablePatternIsUsed {
	TRAction* action1 = [TRAction new];
	
	[table_ add:@"/:id/:name" to:action1 method:@"GET"];
	
	TRRoutingEntry* result;
	TRRoutingEntry* expected;
	
	result = [table_ lookup:@"/100/foo" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id/:name"] action:action1 httpMethod:@"GET"
				params:[NSDictionary dictionaryWithObjectsAndKeys:@"100", @"id", @"foo", @"name", nil]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/foo/100" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id/:name"] action:action1 httpMethod:@"GET"
				params:[NSDictionary dictionaryWithObjectsAndKeys:@"foo", @"id", @"100", @"name", nil]];
	STAssertEqualObjects(result, expected, nil);
}

- (void)testPatternMatchingLastPatterhCharacterSlashIsIgnored {
	TRAction* action1 = [TRAction new];
	
	[table_ add:@"/foo/" to:action1 method:@"GET"];
	
	TRRoutingEntry* result;
	TRRoutingEntry* expected;
	
	result = [table_ lookup:@"/foo/" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/foo/"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/foo" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/foo/"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
}

- (void)testPatternMatchingCaseComplexPatterns {
	TRAction* action1 = [TRAction new];
	TRAction* action2 = [TRAction new];
	TRAction* action3 = [TRAction new];
	
	[table_ add:@"/foo" to:action1 method:@"GET"];
	[table_ add:@"/foo" to:action2 method:@"POST"];
	[table_ add:@"/foo" to:action3 method:@"PUT"];
	[table_ add:@"/hoge/" to:action1 method:@"GET"];
	[table_ add:@"/hoge/" to:action2 method:@"POST"];
	[table_ add:@"/hoge/" to:action3 method:@"PUT"];
	[table_ add:@"/:id" to:action1 method:@"GET"];
	[table_ add:@"/:id" to:action2 method:@"POST"];
	[table_ add:@"/:id" to:action3 method:@"PUT"];
	[table_ add:@"/:id/:name" to:action1 method:@"GET"];
	[table_ add:@"/:id/:name" to:action2 method:@"POST"];
	[table_ add:@"/:id/:name" to:action3 method:@"PUT"];
	
	
	TRRoutingEntry* result;
	TRRoutingEntry* expected;
	
	NSLog(@"Assertions that simple patterns behave correctly");
	result = [table_ lookup:@"/foo" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/foo"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/foo" method:@"POST"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/foo"] action:action2 httpMethod:@"POST" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/foo" method:@"PUT"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/foo"] action:action3 httpMethod:@"PUT" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	
	NSLog(@"Assertions that case when last character of pattern is '/' doesn't have any effect");
	result = [table_ lookup:@"/hoge" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/hoge/"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/hoge" method:@"POST"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/hoge/"] action:action2 httpMethod:@"POST" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/hoge" method:@"PUT"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/hoge/"] action:action3 httpMethod:@"PUT" params:[NSDictionary dictionary]];
	STAssertEqualObjects(result, expected, nil);
	
	
	NSLog(@"Assertions that variable patterns behave correctly");
	result = [table_ lookup:@"/bar" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id"] action:action1 httpMethod:@"GET" params:[NSDictionary dictionaryWithObject:@"bar" forKey:@"id"]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/bar" method:@"POST"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id"] action:action2 httpMethod:@"POST" params:[NSDictionary dictionaryWithObject:@"bar" forKey:@"id"]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/bar" method:@"PUT"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id"] action:action3 httpMethod:@"PUT" params:[NSDictionary dictionaryWithObject:@"bar" forKey:@"id"]];
	STAssertEqualObjects(result, expected, nil);
	
	
	NSLog(@"Assertions that multiple variable patterns behave correctly");
	result = [table_ lookup:@"/100/foo" method:@"GET"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id/:name"] action:action1 httpMethod:@"GET"
				params:[NSDictionary dictionaryWithObjectsAndKeys:@"100", @"id", @"foo", @"name", nil]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/100/foo" method:@"POST"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id/:name"] action:action2 httpMethod:@"POST"
				params:[NSDictionary dictionaryWithObjectsAndKeys:@"100", @"id", @"foo", @"name", nil]];
	STAssertEqualObjects(result, expected, nil);
	
	result = [table_ lookup:@"/100/foo" method:@"PUT"];
	expected = [TRRoutingEntry
				newEntry:[TRPathPattern newPathPattern:@"/:id/:name"] action:action3 httpMethod:@"PUT"
				params:[NSDictionary dictionaryWithObjectsAndKeys:@"100", @"id", @"foo", @"name", nil]];
	STAssertEqualObjects(result, expected, nil);
}

@end
