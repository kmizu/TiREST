//
//  TRRoutingTable.m
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import "TRRoutingTable.h"
#import "TRPathPattern.h"
#import "TRRoutingEntry.h"

@implementation TRRoutingTable {
	NSMutableArray* entries_;
}

@synthesize entries=entries_;

- (id)init {
	self = [super init];
	entries_ = [NSMutableArray array];
	return self;
}

- (void)add:(NSString*)pathPattern to:(TRAction*)action method:(NSString*)httpMethod {
	[entries_ addObject:[TRRoutingEntry newEntry:[TRPathPattern newPathPattern:pathPattern] action:action httpMethod:httpMethod]];
}

- (void)clear {
	[entries_ removeAllObjects];
}

- (TRRoutingEntry*)lookup:(NSString *)pathWithoutQuery method:(NSString *)httpMethod {
	for (TRRoutingEntry* entry in entries_) {
		NSDictionary* matchingResult = [entry.pattern match:pathWithoutQuery];
		NSString* method = entry.httpMethod;
		if (matchingResult && [httpMethod isEqualToString:method]) {
			return [TRRoutingEntry newEntry:entry.pattern action:entry.action httpMethod:httpMethod params:matchingResult];
			
		}
	}
	return nil;
}

@end
