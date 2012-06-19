//
//  TRHTTPResponse.h
//  TiREST
//
//  Created by Kota Mizushima on 12/06/19.
//
//

#import <Foundation/Foundation.h>
#import "HTTPResponse.h"
#import "HTTPDataResponse.h"

@interface TRHTTPResponse : HTTPDataResponse

- (id)initWithData:(NSData *)data status:(NSInteger)status;

- (id)initWithData:(NSData *)data status:(NSInteger)status httpHeaders:(NSDictionary*)httpHeaders;

@end
