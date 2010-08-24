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
@synthesize cArguments;

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector {
	return [self initWithTarget:animationTarget selector:animationSelector continuation:nil continuationSelector:nil];
}

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector arguments:(NSArray *)argumentArray {
	return [self initWithTarget:animationTarget selector:animationSelector arguments:argumentArray continuation:nil continuationSelector:nil continuationArguments:nil];
}

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector continuation:(id)continuationTarget continuationSelector:(SEL)continuationSelector {
	return [self initWithTarget:animationTarget selector:animationSelector arguments:nil continuation:continuationTarget continuationSelector:continuationSelector continuationArguments:nil];
}

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector arguments:(NSArray *)argumentArray continuation:(id)continuationTarget continuationSelector:(SEL)continuationSelector continuationArguments:(NSArray *)continuationArguments {
	if ((self = [super init])) {
		target = [animationTarget retain];
		selector = animationSelector;
		arguments = [argumentArray retain];
		cTarget = [continuationTarget retain];
		cSelector = continuationSelector;
		cArguments = [continuationArguments retain];
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

- (void)performContinuation {
	NSMethodSignature *methodSig = [[cTarget class] instanceMethodSignatureForSelector:cSelector];
	NSInvocation *aInvocation = [NSInvocation invocationWithMethodSignature:methodSig];
	[aInvocation setSelector:cSelector];
	[aInvocation setTarget:cTarget];
	
	int i = 2;
	for (id argument in cArguments) {
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
			[self performContinuation];
		}
	}
	
	if ([self.delegate respondsToSelector:@selector(nextAnimation)]) {
		[self.delegate nextAnimation];
	}
}

- (void)dealloc {
	self.target = nil;
	self.selector = nil;
	self.arguments = nil;
	self.cTarget = nil;
	self.cSelector = nil;
	self.cArguments = nil;
	[super dealloc];
}


@end
