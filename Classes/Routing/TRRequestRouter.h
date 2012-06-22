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

/**
 * This class provides main functionality of TiREST to users.
 * Users can create RESTful APIs by extending this class and
 * overriding |configure| method appreciately.  In the overriden method,
 * User should register routes using |addRouteForGET:|, |addRouteForPOST:|,
 * or |addRouteForPOST:|. Each of the 3 method corresponds GET, POST, and PUT
 * request.
 */
@interface TRRequestRouter : NSObject

@property (nonatomic, weak) HTTPConnection* connection;

+ (TRRequestRouter*)newRequestRouter:(HTTPConnection*)connection;

- (id)initWithHTTPConnection:(HTTPConnection*)connection;

- (void)addRouteForGET:(NSString*)pathPattern to:(TRAction*)action;

- (void)addRouteForPOST:(NSString*)pathPattern to:(TRAction*)action;

- (void)addRouteForPUT:(NSString*)pathPattern to:(TRAction*)action;

- (void)addRoute:(NSString*)pathPattern to:(TRAction*)action method:(NSString*)httpMethod;

- (NSDictionary*)dispatchFor:(NSString*)httpMethod path:(NSString*)path body:(NSData*)body;

/**
 * This is an abstract method.  User should override this method to craete RESTful APIs.
 */
- (void)configure;

@end
