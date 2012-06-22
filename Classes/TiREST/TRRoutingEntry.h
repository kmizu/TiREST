//
//  TRRoutingResult.h
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import <Foundation/Foundation.h>
#import "TRAction.h"
#import "TRPathPattern.h"

@interface TRRoutingEntry : NSObject

@property (nonatomic) TRPathPattern* pattern;
@property (nonatomic) TRAction* action;
@property (nonatomic) NSString* httpMethod;
@property (nonatomic) NSDictionary* params;

- (id)init:(TRPathPattern*)pattern action:(TRAction*)action httpMethod:(NSString*)httpMethod params:(NSDictionary*)params;

+ (TRRoutingEntry*)newEntry:(TRPathPattern*)pattern action:(TRAction*)action httpMethod:(NSString*)httpMethod;

+ (TRRoutingEntry*)newEntry:(TRPathPattern*)pattern action:(TRAction*)action httpMethod:(NSString*)httpMethod params:(NSDictionary*)params;

@end
