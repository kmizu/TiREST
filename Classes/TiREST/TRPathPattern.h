//
//  TRPathPattern.h
//  TiREST
//
//  Created by Kota Mizushima on 12/06/21.
//
//

#import <Foundation/Foundation.h>

/**
 *  This class represents a pattern to match a part of URL.
 *  Regularlly, |patern| starts with "/".  Empty path components
 *  are canonicalized.  For example, |pattern|  "//a//b" is same
 *  as "/a/b".
 *
 *  This class supports both literal patterns, such as "/hello",
 *  and variable pattern, such as "/:id/".  Of course, they
 *  can be mixed into one |pattern|.
 *
 *  Note that this class assumes that query string is eliminated
 *  from |pattern|.
 */
@interface TRPathPattern : NSObject {
	NSString* pattern_;
}

@property (nonatomic) NSString* pattern;

/**
 * Just a shorthand of |(TRPathPattern*)[[TRPathPattern alloc] initWith:pathPattern]|.
 */
+ (TRPathPattern*)newPathPattern:(NSString*)pathPattern;

/**
 * A designated initializer of this class.
 *
 * @param pathPattern pattern string
 * @return self
 */
- (id)initWith:(NSString*)pathPattern;

/**
 *  Execute pattern matching against |requestPath|.
 *  This method doesn't prefix, suffix, or infix matching
 *  but "exact" matching.  Assume |pattern| is "/:id/foo/".
 *  In this case, |pattern| matches to |requestPath| "/100/foo/", "/100/foo",
 *  and so on.  However, it doesn't match to |requestPath| neither
 *  "aprefix/100/foo/",  "aprefix/100/foo", nor "/100/foo/asuffix".
 *
 *  @param requestPath an |NSString| to be matched.
 *  @return an |NSDictionary|.  It consists of pairs
 *  of name of a variable pattern and path component to which the
 *  variable pattern matched
 */
- (NSDictionary*)match:(NSString*)requestPath;

@end

@interface TRPathPattern(Private)

/**
 * Trim empty path components from |components| so that canonicalize |pattern|.
 */
- (NSArray*)trimEmptyComponents:(NSArray*)components;

@end