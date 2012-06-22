//
//  Action.m
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TRAction.h"

@implementation TRAction

- (NSDictionary*)process:(NSDictionary*)params body:(NSData*)body {
	assert(NO);
}

- (NSDictionary*)response:(NSUInteger)statusCode {
	return [self response:statusCode text:@""];
}

- (NSDictionary*)response:(NSUInteger)statusCode text:(NSString*)text {
	NSNumber* wrappedCode = [NSNumber numberWithInt:statusCode];
	return [NSDictionary dictionaryWithObjectsAndKeys:
		wrappedCode,		@"status",
		text,				@"response", nil];
}

- (NSDictionary*)response:(NSUInteger)statusCode data:(NSData*)data {
	NSNumber* wrappedCode = [NSNumber numberWithInt:statusCode];
	
	NSDictionary* responseDictionary;
	if (data) responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
	return [NSDictionary dictionaryWithObjectsAndKeys:
		wrappedCode,		@"status",
		responseDictionary, @"response", nil];
}

- (NSDictionary*)notFound {
	return [self response:404];
}

- (NSDictionary*)successWithText:(NSString *)text {
	return [self response:200 text:text];
}

- (NSDictionary*)successWithJSON:(NSDictionary*)json {
	if (json) {
		NSData* jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
		return [self response:200 data:jsonData];
	}
	return [self response:200 data:nil];
}

- (NSDictionary*)success:(NSData*)data {
	return [self response:200 data:data];
}

@end
