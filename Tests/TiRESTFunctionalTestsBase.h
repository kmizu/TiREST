//
//  TiRESTFunctionalTests.h
//  TiRESTFunctionalTests
//
//  Created by Kota Mizushima on 12/06/20.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "TiREST.h"

@interface TiRESTFunctionalTestsBase : SenTestCase

@property (nonatomic) TRTiRESTServer* server;

@end
