TiREST
===================

TiREST is a very tiny, tiny framework for providing RESTful API in LAN between iPad.
Currently, support a simple path pattern with HTTP GET/POST/PUT.  Note that this is 
**experimental** software now.

This software is distributed under the Modified BSD License.  You can see the detail
in [LICENSE.txt](https:/github.com/kmizu/TiREST/blob/master/LICENSE.txt).

In this software, [CocoaHTTPServer](https://github.com/robbiehanson/CocoaHTTPServer) is used.

# First example

You can start TiREST with the following simple example codes:

```objc
#import <TiREST/TiREST.h>

@interface HelloRouter : TRCinatraRouter

@end
```

```objc
#import "HelloRouter.h"

@implementation HelloRouter

- (void)configure {
  [self get:@"/" on:^(TRAction* action, NSDictionary* params, NSData* body) {
      return [action successWithText:@"<html><head><title>Hello, TiREST</title></head><body><h1>Hello, TiREST</h1>"];
   }];

@end
```

```objc
#import <TiREST/TiREST.h>
...
TRTiRESTServer* server = [TRTiRESTServer newServer:12345 routerClass:[HelloRouter class]];
    
NSError* error = nil;
if(![server start:&error]) {
  DDLogError(@"Error starting HTTP Server: %@", error);
} 
...
```

After the folowing code is executed and the return value is YES, then a tiny HTTP server starts
with specified port number in your iPad or iOS simulator.

```
[server start:&error];
```

After you access URL "http://your_device_name:12345/" (iPad) or "http://localhost:12345/" (Simulator)
with your web browser,  "Hello, TiREST" will be shown in your web browser.

# Note

The documentation of the library is not enough.  If you would like to know the detail, see the 
source codes.  Specifically, tests under [Tests](https://github.com/kmizu/TiREST/tree/master/Tests)
directory would be helpful.
