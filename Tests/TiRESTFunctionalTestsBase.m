//
//  TiRESTFunctionalTests.m
//  TiRESTFunctionalTests
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import "TiRESTFunctionalTestsBase.h"
#import "TiREST.h"
#import "TRSimpleTestRouter.h"

@implementation TiRESTFunctionalTestsBase {
	TRTiRESTServer* server_;
}

@synthesize server=server_;

- (void)setUp {
    [super setUp];
	server_ = [TRTiRESTServer newServer:12345 routerClass:[TRSimpleTestRouter class]];
	
	[server_ start:nil];
}

- (void)tearDown {
	[server_ stop];
	server_ = nil;
    
    [super tearDown];
}


@end
