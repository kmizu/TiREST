//
//  Action.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject

//TODO should be enable to return a response depending on |params|
/**
 Process HTTP request.  This method is abstract and must be implemented in subclasses.
 */
- (void)process:(NSDictionary*)params body:(NSData*)body;

@end
