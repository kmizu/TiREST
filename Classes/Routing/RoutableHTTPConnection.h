//
//  RoutableHTTPConnection.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HTTPConnection.h"
#import "RequestRouter.h"

@interface RoutableHTTPConnection : HTTPConnection {
	NSData* dataBody_;
	NSUInteger contentLength_;
	RequestRouter* router_;
}

@property (nonatomic) NSData* dataBody;
@property (nonatomic) RequestRouter* router;

- (NSUInteger)contentLength;

@end
