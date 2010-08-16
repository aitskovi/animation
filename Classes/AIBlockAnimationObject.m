//
//  AIBlockAnimationObject.m
//  Animation
//
//  Created by Avi Itskovich on 10-08-08.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import "AIBlockAnimationObject.h"

@implementation AIBlockAnimationObject

- (id)initWithBlock:(void (^)(void))animationBlock {
	return [self initWithBlock:animationBlock continuation:nil];
}

- (id)initWithBlock:(void (^)())animationBlock continuation:(void (^)())continuationBlock {
	if (self = [super init]) {
		animation = [animationBlock copy];
		continuation = [continuationBlock copy];
	}
	return self;
}


- (void)play {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationEnded)];
	animation();
	[UIView commitAnimations];
}

// Play the continuation before the nextAnimation
- (void)animationEnded {
	// Blocks can't be nil
	if (continuation != nil) {
		continuation();
	}
	
	if ([self.delegate respondsToSelector:@selector(nextAnimation)]) {
		[self.delegate nextAnimation];
	}
}

- (void)dealloc {
	[animation release];
	[continuation release];
	[super dealloc];
}
@end
