//
//  Action.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TRAction : NSObject


//TODO should be enable to return a response depending on |params|
/**
 Process HTTP request.  This method is abstract and must be implemented in subclasses.
 */
- (NSDictionary*)process:(NSDictionary*)params body:(NSData*)body;

- (NSDictionary*)response:(NSUInteger)statusCode;

- (NSDictionary*)response:(NSUInteger)statusCode text:(NSString*)text;

- (NSDictionary*)response:(NSUInteger)statusCode data:(NSData*)data;

- (NSDictionary*)notFound;

- (NSDictionary*)successWithText:(NSString*)text;

- (NSDictionary*)successWithJSON:(NSDictionary*)json;
	
- (NSDictionary*)success:(NSData*)data;

@end
