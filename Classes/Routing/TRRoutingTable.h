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
 * An |NSArray| which represents
 */
@property (nonatomic) NSArray* entries;

- (void)add:(NSString*)pathPattern to:(TRAction*)action method:(NSString*)httpMethod;

- (void)clear;

- (TRRoutingEntry*)lookup:(NSString*)pathWithoutQuery method:(NSString*)httpMethod;

@end
