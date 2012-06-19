//
//  Action.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * This class is for providing the way to
 * route HTTP GET/POST/PUT request to user-defined code
 * and return HTTP responses.  This class is abstract and
 * must be subclassed.  In subclasses of the class, user
 * must override |process:body:| method using the utility methods.
 */
@interface TRAction : NSObject


/**
 * Process HTTP a request and return response as an |NSDictionary|.  
 * This method is abstract and must be implemented in subclasses.
 * 
 * @param params query parameter.
 * @param body request body
 * @return an |NSDictionary|, represents a response for the request.
 */
- (NSDictionary*)process:(NSDictionary*)params body:(NSData*)body;

/**
 * Generate a response |NSDictionary| with |statusCode|.
 * Call of this method is just shorthand of:
 *    [self response:statusCode text:@""];
 * 
 * @param statusCode HTTP status code to respond
 */
- (NSDictionary*)response:(NSUInteger)statusCode;

/**
 * Generate a response |NSDictionary| with |statusCode| and |text|.
 * 
 * @param statusCode HTTP status code to respond
 * @param text response body
 */
- (NSDictionary*)response:(NSUInteger)statusCode text:(NSString*)text;

/**
 * Generate a response |NSDictionary| with |statusCode| and |data|.
 * 
 * @param statusCode HTTP status code to respond
 * @param data response body
 */
- (NSDictionary*)response:(NSUInteger)statusCode data:(NSData*)data;

/**
 * Generate a response |NSDictionary|, represents 404 not found.
 */
- (NSDictionary*)notFound;

/**
 * Generate a response |NSDictionary|, represents successfull response.
 * 
 * @param text response body
 */
- (NSDictionary*)successWithText:(NSString*)text;

/**
 * Generate a response |NSDictionary|, represents successfull response.
 * 
 * @param json response body
 */
- (NSDictionary*)successWithJSON:(NSDictionary*)json;

/**
 * Generate a response |NSDictionary|, represents successfull response.
 * 
 * @param data response body
 */
- (NSDictionary*)success:(NSData*)data;

@end
