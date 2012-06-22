//
//  TRCinatraRouter.h
//  TiREST
//
//  Created by Kota Mizushima on 12/06/19.
//
//

#import "TRRequestRouter.h"
#import "TRAction.h"
#import "TRBlocksAction.h"

/**
 * |TRCinatraRouter| is a subclass of |TRRequestRouter|.
 * It supports Sinatra-like notation in addition to normal notation.
 */
@interface TRCinatraRouter : TRRequestRouter

/**
 * |[self get:pathPattern on:action]| is just shorthand of
 * |[self addRouteForGET:pathPattern to:[BlocksAction newAction:action]]|.
 */
- (void)get:(NSString*)pathPattern on:(ActionFunction)action;

/**
 * |[self post:pathPattern on:action]| is just shorthand of
 * |[self addRouteForPOST:pathPattern to:[BlocksAction newAction:action]]|.
 */
- (void)post:(NSString*)pathPattern on:(ActionFunction)action;

/**
 * |[self put:pathPattern on:action]| is just shorthand of
 * |[self addRouteForPUT:pathPattern to:[BlocksAction newAction:action]]|.
 */
- (void)put:(NSString*)pathPattern on:(ActionFunction)action;

@end
