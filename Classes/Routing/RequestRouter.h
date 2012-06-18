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

@interface RequestRouter : NSObject

@property (nonatomic, weak) HTTPConnection* connection;

+ (RequestRouter*)newRequestRouter:(HTTPConnection*)connection;

- (void)addRoute:(NSString*)pathPattern to:(Action*)action;

- (NSData*)dispatchFor:(NSString*)httpMethod path:(NSString*)path body:(NSData*)body;

@end
