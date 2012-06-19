//
//  BlocksAction.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TRAction.h"

typedef NSDictionary* (^ActionFunction)(TRAction* action, NSDictionary* params, NSData* body);

@interface TRBlocksAction : TRAction {
	ActionFunction action_;
}

@property (nonatomic, readonly) ActionFunction action;

+ (TRBlocksAction*)newAction:(ActionFunction)action;

- (id)initWithActionFunction:(ActionFunction)action;

@end
