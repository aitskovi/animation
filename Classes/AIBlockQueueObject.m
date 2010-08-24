//
//  AIBlockQueueObject.m
//  Animation
//
//  Created by Avi Itskovich on 10-08-24.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import "AIBlockQueueObject.h"


@implementation AIBlockQueueObject

#pragma mark -
#pragma mark Initialization

- (id)initWithAnimation:(void (^)(void))animation {
	if ((self = [self initWithBlock:animation])) {
		animated = YES;
	}
	return self;
}

- (id)initWithComputation:(void (^)(void))computation {
	if ((self = [self initWithBlock:computation])) {
		animated = NO;
	}
	return self;
}

- (id)initWithBlock:(void (^)(void))aBlock {
	if ((self = [super init])) {
		block = [aBlock copy];
	}
	return self;
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	[block release];
	block = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark Block Actions

- (void)play {
	if (animated) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(next)];
	}
	
	if (block) block();
	
	if (animated) {
		[UIView commitAnimations];
	} else {
		[self next];
	}
}

@end
