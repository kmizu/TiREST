//
//  TiRESTFunctionalTests.h
//  TiRESTFunctionalTests
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "TiREST.h"
#define TEST_ENDPOINT (@"http://localhost:12345")

@interface TiRESTFunctionalTestsBase : SenTestCase

@property (nonatomic) TRTiRESTServer* server;

- (Class)routerClass;

@end
