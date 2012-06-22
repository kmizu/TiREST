//
//  TRCinatraRouter.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/19.
//
//

#import "TRCinatraRouter.h"
#import "TRBlocksAction.h"

@implementation TRCinatraRouter

- (void)get:(NSString*)pathPattern on:(ActionFunction)action {
	[self addRouteForGET:pathPattern to:[TRBlocksAction newAction:action]];
}

- (void)post:(NSString*)pathPattern on:(ActionFunction)action {
	[self addRouteForPOST:pathPattern to:[TRBlocksAction newAction:action]];
}

- (void)put:(NSString*)pathPattern on:(ActionFunction)action {
	[self addRouteForPUT:pathPattern to:[TRBlocksAction newAction:action]];
}

@end
