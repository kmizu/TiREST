//
//  RequestRouter.m
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RequestRouter.h"

@implementation RequestRouter {
	NSMutableArray* pathPatterns_;
	NSMutableArray* actions_;
}

-(id) init {
	self = [super init];
	pathPatterns_ = [NSMutableArray array];
	actions_ = [NSMutableArray array];
	return self;
}

-(void) route:(NSString *)pathPattern to:(Action *)action {
	[pathPatterns_ addObject:pathPattern];
	[actions_ addObject:action];
}

@end
