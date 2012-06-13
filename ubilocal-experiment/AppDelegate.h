//
//  AppDelegate.h
//  ubilocal-experiment
//
//  Created by Mizushima Kota on 12/06/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServer.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
	HTTPServer* httpServer_;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
