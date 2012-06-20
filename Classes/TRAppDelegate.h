//
//  AppDelegate.h
//  
//
//  Created by Mizushima Kota on 12/06/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServer.h"

@class TRViewController;

@interface TRAppDelegate : UIResponder <UIApplicationDelegate> 

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TRViewController *viewController;

@end
