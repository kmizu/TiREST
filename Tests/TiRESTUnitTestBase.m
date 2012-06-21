//
//  TiRESTFunctionalTests.m
//  TiRESTFunctionalTests
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TiRESTUnitTestBase.h"
#import "TiREST.h"
#import "TRSimpleGETTestRouter.h"

@implementation TiRESTUnitTestBase {
	TRTiRESTServer* server_;
}

@synthesize server=server_;

- (void)setUp {
    [super setUp];
	server_ = [TRTiRESTServer newServer:12345 routerClass:self.routerClass];
	
	[server_ start:nil];
}

- (Class)routerClass {
	assert(NO);
}

- (void)tearDown {
	[server_ stop];
	server_ = nil;
    
    [super tearDown];
}


@end
