//
//  BlocksAction.m
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BlocksAction.h"

@implementation BlocksAction 

- (ActionFunction)action {
	return action_;
}

+ (BlocksAction*)newAction:(ActionFunction)action {
	BlocksAction* blocksAction = [[BlocksAction alloc] initWithActionFunction:action];
	return blocksAction;
}

- (id)initWithActionFunction:(ActionFunction)action {
	self = [super init];
	action_ = action;
	
	return self;
}

- (NSDictionary*)process:(NSDictionary *)params body:(NSData *)body {
	return action_(self, params, body);
}

@end
