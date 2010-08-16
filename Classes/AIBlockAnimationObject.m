//
//  AIBlockAnimationObject.m
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
