//
//  AISelectorAnimationObject.m
//  Animation
//
//  Created by Avi Itskovich on 10-08-08.
//  Copyright 2010 Avi Itskovich. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "AISelectorAnimationObject.h"

@implementation AISelectorAnimationObject

@synthesize target;
@synthesize selector;
@synthesize cTarget;
@synthesize cSelector;

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector {
	return [self initWithTarget:animationTarget selector:animationSelector continuation:nil continuationSelector:nil];
}

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector continuation:(id)continuationTarget continuationSelector:(SEL)continuationSelector {
	if ((self = [super init])) {
		self.target = animationTarget;
		self.selector= animationSelector;
		self.cTarget = continuationTarget;
		self.cSelector = continuationSelector;
	}
	return self;
}

- (void)play {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationEnded)];
	if ([self.target respondsToSelector:self.selector]) {
		[self.target performSelector:self.selector];
	}
	[UIView commitAnimations];
}

- (void)animationEnded {
	if (cSelector != nil) {
		if ([self.cTarget respondsToSelector:self.cSelector]) {
			[self.cTarget performSelector:self.cSelector];
		}
	}
	
	if ([self.delegate respondsToSelector:@selector(nextAnimation)]) {
		[self.delegate nextAnimation];
	}
}

- (void)dealloc {
	self.target = nil;
	self.selector = nil;
	self.cTarget = nil;
	self.cSelector = nil;
	[super dealloc];
}


@end
