//
//  TRHTTPResponse.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/19.
//
//

#import "TRHTTPResponse.h"

@implementation TRHTTPResponse {
	NSInteger status_;
	NSDictionary* httpHeaders_;
}

- (id)initWithData:(NSData *)dataParam status:(NSInteger)status {
	self = [self initWithData:dataParam status:status httpHeaders:nil];
	
	return self;
}

- (id)initWithData:(NSData *)dataParam status:(NSInteger)status httpHeaders:(NSDictionary*)httpHeaders {
	self = [super initWithData:dataParam];
	status_ = status;
	httpHeaders_ = httpHeaders;
	
	return self;
}

- (NSInteger)status {
	return status_;
}

- (NSDictionary *)httpHeaders {
	return httpHeaders_;
}

@end
