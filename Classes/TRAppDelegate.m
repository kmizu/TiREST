//
//  AppDelegate.m
//  
//
//  Created by Mizushima Kota on 12/06/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TRAppDelegate.h"

#import "TRViewController.h"
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "TRRoutableHTTPConnection.h"
#import "TRExampleRouter.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation TRAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.viewController = [[TRViewController alloc] initWithNibName:@"ViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
	// Configure our logging framework.
	// To keep things simple and fast, we're just going to log to the Xcode console.
	[DDLog addLogger:[DDTTYLogger sharedInstance]];
	
	httpServer_ = [[HTTPServer alloc] init];
	
	// Tell the server to broadcast its presence via Bonjour.
	// This allows browsers such as Safari to automatically discover our service.
	[httpServer_ setType:@"_http._tcp."];
	
	// Note that call of [TRRoutableHTTPConnection setRouterClass:(Class)klass] is needed.
	[TRRoutableHTTPConnection setRouterClass:[TRExampleRouter class]];
	[httpServer_ setConnectionClass:[TRRoutableHTTPConnection class]];
	
	[httpServer_ setPort:12345];
	
	NSString* webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
	
	[httpServer_ setDocumentRoot:webPath];
	
	NSError* error = nil;
	if(![httpServer_ start:&error]) {
		DDLogError(@"Error starting HTTP Server: %@", error);
		return NO;
	} 
	NSLog(@"Started HTTP Server on port %u, %@, domain=%@", [httpServer_ listeningPort], [httpServer_ documentRoot], [httpServer_ domain]);
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
