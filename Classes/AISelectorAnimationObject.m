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
@synthesize arguments;

@synthesize cTarget;
@synthesize cSelector;

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector {
	return [self initWithTarget:animationTarget selector:animationSelector continuation:nil continuationSelector:nil];
}

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector arguments:(NSArray *)argumentArray {
	self = [self initWithTarget:animationTarget selector:animationSelector];
	self.arguments = argumentArray;
	return self;
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

- (void)performAnimation {
	NSMethodSignature *methodSig = [[target class] instanceMethodSignatureForSelector:selector];
	NSInvocation *aInvocation = [NSInvocation invocationWithMethodSignature:methodSig];
	[aInvocation setSelector:selector];
	[aInvocation setTarget:target];
	
	int i = 2;
	for (id argument in arguments) {
		[aInvocation setArgument:&argument atIndex:i];
		i++;
	}
	
	[aInvocation invoke];
}

- (void)play {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationEnded)];
	if ([self.target respondsToSelector:self.selector]) {
		[self performAnimation];
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
