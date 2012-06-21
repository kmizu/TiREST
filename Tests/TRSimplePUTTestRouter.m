//
//  TRSimplePUTTestRouter.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TRSimplePUTTestRouter.h"

@implementation TRSimplePUTTestRouter {
	NSMutableDictionary* resources_;
}

- (void)configure {
	resources_ = [NSMutableDictionary dictionary];
	[self put:@"/hello.txt" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		NSString* content = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
		[resources_ setObject:content forKey:@"hello.txt"];
		
		return [action successWithText:@"PUT /hello.txt"];
	}];
	[self get:@"/hello.txt" on:^(TRAction* action, NSDictionary* params, NSData* body) {
		NSString* content = [resources_ objectForKey:@"hello.txt"];
		
		if (content) {
			return [action successWithText:content];
		} else {
			return [action notFound];
		}
	}];
}

@end
