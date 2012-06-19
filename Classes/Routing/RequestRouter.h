//
//  RequestRouter.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"
#import "HTTPConnection.h"

#define QUERY_DELIMITER (@"?")

@interface RequestRouter : NSObject

@property (nonatomic, weak) HTTPConnection* connection;

+ (RequestRouter*)newRequestRouter:(HTTPConnection*)connection;

- (void)addRouteForGET:(NSString*)pathPattern to:(Action*)action;

- (void)addRouteForPOST:(NSString*)pathPattern to:(Action*)action;

- (void)addRouteForPUT:(NSString*)pathPattern to:(Action*)action;

- (void)addRoute:(NSString*)pathPattern to:(Action*)action method:(NSString*)httpMethod;

- (NSDictionary*)dispatchFor:(NSString*)httpMethod path:(NSString*)path body:(NSData*)body;

@end
