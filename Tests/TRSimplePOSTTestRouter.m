//
//  TRSimplePOSTTestRouter.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TRSimplePOSTTestRouter.h"

@implementation TRSimplePOSTTestRouter {
	NSString* storedValue_;
}

- (void)configure {
	[self post:@"/" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithText:@"POST /"];
	}];
	[self post:@"/echo" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		NSString* bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
		return [action successWithText:bodyString];
	}];
	[self post:@"/set_value" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		storedValue_ = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
		return [action successWithText:[NSString stringWithFormat:@"stored value = %@", storedValue_]];
	}];
	[self get:@"/get_value" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		return [action successWithText:[NSString stringWithFormat:@"%@", storedValue_]];
	}];
}

@end
