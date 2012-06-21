//
//  TRRoutingTable.h
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import <Foundation/Foundation.h>
#import "TRRoutingEntry.h"

@interface TRRoutingTable : NSObject

@property (nonatomic) NSArray* entries;

- (void)add:(NSString*)pathPattern to:(TRAction*)action method:(NSString*)httpMethod;

- (void)clear;

- (TRRoutingEntry*)lookup:(NSString*)pathWithoutQuery method:(NSString*)httpMethod;

@end
