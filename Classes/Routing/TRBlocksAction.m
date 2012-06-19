//
//  BlocksAction.m
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TRBlocksAction.h"

@implementation TRBlocksAction 

- (ActionFunction)action {
	return action_;
}

+ (TRBlocksAction*)newAction:(ActionFunction)action {
	TRBlocksAction* blocksAction = [[TRBlocksAction alloc] initWithActionFunction:action];
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
