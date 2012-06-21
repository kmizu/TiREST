//
//  TRSimpleUsingPatternRouter.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TRSimpleGETUsingPatternTestRouter.h"

@implementation TRSimpleGETUsingPatternTestRouter

- (void)configure {
	[self get:@"/hello/:your_name/" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		NSString* yourName = [params objectForKey:@"your_name"];
		return [action successWithText:
				[NSString stringWithFormat:@"<html><head><title>Hello, %@</title></head><body><h1>Hello, %@</h1>", yourName, yourName]];
	}];
}

@end
