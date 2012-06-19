//
//  RoutableHTTPConnection.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HTTPConnection.h"
#import "TRRequestRouter.h"

@interface TRRoutableHTTPConnection : HTTPConnection {
	NSData* dataBody_;
	NSUInteger contentLength_;
	TRRequestRouter* router_;
}

@property (nonatomic) NSData* dataBody;
@property (nonatomic) TRRequestRouter* router;

@end
