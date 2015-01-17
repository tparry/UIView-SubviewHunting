UIView+SubviewHunting
===========

`UIView+SubviewHunting` is an iOS category for `UIView` for easily searching through the UIView hierarchy. This can be useful when writing code to search through or manipulate a UIView's private subviews.

Usage
-----

A test block is used to do custom evaluation on subviews, this allows for custom search criteria.

    NSArray *matchingViews = [self.view subviewsPassingTest:^BOOL(UIView *view, NSUInteger depth, EnumerationAction *action) {
    	
    	//	Any UIImageView
    	return [view isKindOfClass:[UIImageView class]];
    }];
.

    NSArray *matchingViews = [self.view subviewsPassingTest:^BOOL(UIView *view, NSUInteger depth, EnumerationAction *action) {
    	
    	//	Maximum search depth of 6
    	if(depth >= 6)
    		*action = EnumerationActionSkipChildren;
    	
    	//	Any view matching the private class type of MPKnockoutButton
    	return [NSStringFromClass([view class]) isEqualToString:@"MPKnockoutButton"];
    }];
.

    NSArray *matchingViews = [self.view subviewsPassingTest:^BOOL(UIView *view, NSUInteger depth, EnumerationAction *action) {
    	
    	//	Any control smaller than 60x60
    	return ([view isKindOfClass:[UIControl class]] &&
    			view.frame.size.width < 60 && view.frame.size.height < 60);
    }];
