//
//  TRCinatraRouter.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/19.
//
//

#import "TRCinatraRouter.h"

@implementation TRCinatraRouter

- (void)get:(NSString*)pathPattern on:(ActionFunction)action {
	[self addRouteForGET:pathPattern to:Block_copy(action)];
}

- (void)post:(NSString*)pathPattern on:(ActionFunction)action {
	[self addRouteForPOST:pathPattern to:Block_copy(action)];
}

- (void)put:(NSString*)pathPattern on:(ActionFunction)action {
	[self addRouteForPUT:pathPattern to:Block_copy(action)];
}

@end
