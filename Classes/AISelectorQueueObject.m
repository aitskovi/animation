//
//  AISelectorQueueObject.m
//  Animation
//
//  Created by Avi Itskovich on 10-08-24.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import "AISelectorQueueObject.h"


@implementation AISelectorQueueObject

@synthesize selector;
@synthesize target;
@synthesize paremeters;

- (id)initWithComputation:(SEL)aSelector target:(id)aTarget arguments:(NSArray *)paremeterArray {
	if ((self = [self initWithSelector:aSelector target:aTarget arguments:paremeterArray])) {
		animation = NO;
	}
	return self;
}

- (id)initWithAnimation:(SEL)aSelector target:(id)aTarget arguments:(NSArray *)paremeterArray {
	if ((self = [self initWithSelector:aSelector target:aTarget arguments:paremeterArray])) {
		animation = YES;
	}
	return self;
}

- (id)initWithSelector:(SEL)aSelector target:(id)aTarget arguments:(NSArray *)paremeterArray {
	if ((self = [super init])) {
		selector = aSelector;
		target = [aTarget retain];
		paremeters = [paremeterArray retain];
	}
	return self;
}

- (void)dealloc {
	selector = nil;
	[target release];
	target = nil;
	[parameters release];
	parameters = nil;
	[super dealloc];
}

- (void)performSelector {
	NSMethodSignature *methodSig = [[target class] instanceMethodSignatureForSelector:selector];
	NSInvocation *aInvocation = [NSInvocation invocationWithMethodSignature:methodSig];
	[aInvocation setSelector:selector];
	[aInvocation setTarget:target];
	
	int i = 2;
	for (id parameter in paremeters) {
		[aInvocation setArgument:&parameter atIndex:i];
		i++;
	}
	
	[aInvocation invoke];
}

- (void)play {
	if (animation) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(next)];
	}
	[self performSelector];
	if (animation) 
		[UIView commitAnimations];
	else 
		[self next];
}

@end
