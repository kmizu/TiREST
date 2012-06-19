//
//  BlocksAction.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Action.h"

typedef NSDictionary* (^ActionFunction)(Action* action, NSDictionary* params, NSData* body);

@interface BlocksAction : Action {
	ActionFunction action_;
}

@property (nonatomic, readonly) ActionFunction action;

+ (BlocksAction*)newAction:(ActionFunction)action;

- (id)initWithActionFunction:(ActionFunction)action;

@end
