//
//  This is free and unencumbered software released into the public domain.
//
//  Anyone is free to copy, modify, publish, use, compile, sell, or
//  distribute this software, either in source code form or as a compiled
//  binary, for any purpose, commercial or non-commercial, and by any
//  means.
//
//  In jurisdictions that recognize copyright laws, the author or authors
//  of this software dedicate any and all copyright interest in the
//  software to the public domain. We make this dedication for the benefit
//  of the public at large and to the detriment of our heirs and
//  successors. We intend this dedication to be an overt act of
//  relinquishment in perpetuity of all present and future rights to this
//  software under copyright law.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
//  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//
//  For more information, please refer to <http://unlicense.org/>
//

#import "UIView+SubviewHunting.h"

@implementation UIView (SubviewHunting)

- (NSArray*) subviewsPassingTest:(BOOL (^)(UIView *view, NSUInteger depth, EnumerationAction *action)) predicate
{
	NSMutableArray *subviews = [[NSMutableArray alloc] init];
	
	EnumerationAction action = EnumerationActionContinue;
	
	[self subviewsIntoArray:subviews depth:0 passingTest:predicate action:&action];
	
	return [subviews copy];
}

- (void) subviewsIntoArray:(NSMutableArray*) array depth:(NSUInteger) depth passingTest:(BOOL (^)(UIView *view, NSUInteger depth, EnumerationAction *action)) predicate action:(EnumerationAction*) action
{
	//	End if needed
	if(*action == EnumerationActionStop)
		return;
	
	//	Reset action
	*action = EnumerationActionContinue;
	
	//	If a match, add this view to the array
	if(predicate(self, depth, action))
	{
		[array addObject:self];
	}
	
	//	Continue searching children if needed
	if(*action == EnumerationActionContinue)
	{
		for(UIView *subview in self.subviews)
		{
			[subview subviewsIntoArray:array depth:(depth + 1) passingTest:predicate action:action];
		}
	}
}

@end
