//
//  RequestRouter.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRAction.h"
#import "HTTPConnection.h"

#define QUERY_DELIMITER (@"?")

@interface TRRequestRouter : NSObject

@property (nonatomic, weak) HTTPConnection* connection;

+ (TRRequestRouter*)newRequestRouter:(HTTPConnection*)connection;

- (void)addRouteForGET:(NSString*)pathPattern to:(TRAction*)action;

- (void)addRouteForPOST:(NSString*)pathPattern to:(TRAction*)action;

- (void)addRouteForPUT:(NSString*)pathPattern to:(TRAction*)action;

- (void)addRoute:(NSString*)pathPattern to:(TRAction*)action method:(NSString*)httpMethod;

- (NSDictionary*)dispatchFor:(NSString*)httpMethod path:(NSString*)path body:(NSData*)body;

@end
