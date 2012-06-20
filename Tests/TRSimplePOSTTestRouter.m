//
//  TRSimplePOSTTestRouter.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TRSimplePOSTTestRouter.h"

@implementation TRSimplePOSTTestRouter

- (void)configure {
	[self post:@"/" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithText:@"top"];
	}];
	[self post:@"/echo" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		NSString* bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
		return [action successWithText:bodyString];
	}];
	[self post:@"/params" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithJSON:params];
	}];
}

@end
