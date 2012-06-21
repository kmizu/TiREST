//
//  TiRESTPUTSimpleTestCase.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TiRESTPUTSimpleTestCase.h"
#import "TRSimplePUTTestRouter.h"

@implementation TiRESTPUTSimpleTestCase

- (Class)routerClass {
	return [TRSimplePUTTestRouter class];
}

@end
