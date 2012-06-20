//
//  TRSimpleTestRouter.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TRSimpleGETTestRouter.h"

@implementation TRSimpleGETTestRouter

- (void)configure {
	[self get:@"/" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithText:@"<html><head><title>Hello, TiREST</title></head><body><h1>Hello, TiREST</h1>"];
	}];
	[self get:@"/json_hello" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithJSON:[NSDictionary
										dictionaryWithObjectsAndKeys:@"Hello", @"message", nil]];
	}];
	[self get:@"/params" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithJSON:params];
	}];
}

@end
