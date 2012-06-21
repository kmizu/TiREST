//
//  TRPathPattern.h
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import <Foundation/Foundation.h>

@interface TRPathPattern : NSObject {
	NSString* pattern_;
}

@property (nonatomic) NSString* pattern;

+ (TRPathPattern*)newPathPattern:(NSString*)pathPattern;

- (id)initWith:(NSString*)pathPattern;

- (NSDictionary*)match:(NSString*)requestPath;

@end

@interface TRPathPattern(Private)

- (NSArray*)trimEmptyComponents:(NSArray*)components;

@end