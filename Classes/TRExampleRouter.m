//
//  TRExampleRouter.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/19.
//
//

#import "TRExampleRouter.h"
#import "TRBlocksAction.h"

@implementation TRExampleRouter

- (void)configure {
	[self get:@"/" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithText:@"<html><head><title>Hello, iPad</title></head><body><h1>Hello, iPad</h1>"];
	}];
	[self get:@"/hello" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithJSON:[NSDictionary
										dictionaryWithObjectsAndKeys:@"Hello", @"message", nil]];
	}];
	[self get:@"/params" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithJSON:params];
	}];
}

@end
