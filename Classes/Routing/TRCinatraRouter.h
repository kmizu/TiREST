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

@interface TRCinatraRouter : TRRequestRouter

- (void)get:(NSString*)pathPattern on:(ActionFunction)action;
- (void)post:(NSString*)pathPattern on:(ActionFunction)action;
- (void)put:(NSString*)pathPattern on:(ActionFunction)action;

@end
