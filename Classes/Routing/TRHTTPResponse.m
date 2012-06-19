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

- (id)initWithData:(NSData *)data status:(NSInteger)status {
	self = [self initWithData:data status:status httpHeaders:nil];
	
	return self;
}

- (id)initWithData:(NSData *)data status:(NSInteger)status httpHeaders:(NSDictionary*)httpHeaders {
	self = [super initWithData:data];
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
