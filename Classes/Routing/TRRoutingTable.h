//
//  TRRoutingTable.h
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import <Foundation/Foundation.h>
#import "TRRoutingEntry.h"

/**
 * This class provides pattern matching functionality for binding a HTTP request to
 * users' code, which is represented as an |TRAction|.
 */
@interface TRRoutingTable : NSObject

/**
 * An |NSArray| which represents array of a |TRRoutingEntry|.
 */
@property (nonatomic) NSArray* entries;

/**
 * Add route to this object.  A route is like a mapping function
 * ((NSString*)pathPattern, (NSString*)httpMethod) => ((TRAction*)action).
 */
- (void)add:(NSString*)pathPattern to:(TRAction*)action method:(NSString*)httpMethod;

/**
 * Clear all routes already registered from this table.
 */
- (void)clear;

/**
 * Execute lookup against |pathQithoutQuery| and |httpMethod|.
 * If the both matches to one of registered routes, this method returns the result as |TRRoutingResult|.
 * If not matched, this method returns nil.  Note that routes are ordered.  Once a precedent
 * route was found, the other routes is not considered.
 *
 * @param pathWithQuery a part of URL that assume URL scheme, query string, and host name is eliminated.
 *
 * @return result of lookup.
 */
- (TRRoutingEntry*)lookup:(NSString*)pathWithoutQuery method:(NSString*)httpMethod;

@end
