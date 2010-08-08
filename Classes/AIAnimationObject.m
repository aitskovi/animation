//
//  AIAnimationObject.m
//  Animation
//
//  Created by Avi Itskovich on 10-08-07.
//  Copyright 2010 Avi Itskovich. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//
#import "AIAnimationObject.h"


@implementation AIAnimationObject

@synthesize delegate;
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
	self.delegate = nil;
	self.target = nil;
	self.selector = nil;
	[super dealloc];
}

@end
