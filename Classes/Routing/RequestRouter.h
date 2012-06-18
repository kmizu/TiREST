//
//  RequestRouter.h
//  local-http-communication
//
//  Created by Mizushima Kota on 12/06/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"

@interface RequestRouter : NSObject

-(void) route:(NSString*)pathPattern to:(Action*)action;

@end
