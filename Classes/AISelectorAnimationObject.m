//
//  AISelectorAnimationObject.m
//  Animation
//
//  Created by Avi Itskovich on 10-08-08.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import "AISelectorAnimationObject.h"


@implementation AISelectorAnimationObject

@synthesize target;
@synthesize selector;

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector {
	if ((self = [super init])) {
		self.target = animationTarget;
		self.selector= animationSelector;
	}
	return self;
}

- (void)play {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self.delegate];
	[UIView setAnimationDidStopSelector:@selector(nextAnimation)];
	if ([self.target respondsToSelector:self.selector]) {
		[self.target performSelector:self.selector];
	}
	[UIView commitAnimations];
}

- (void)dealloc {
	self.target = nil;
	self.selector = nil;
	[super dealloc];
}


@end
