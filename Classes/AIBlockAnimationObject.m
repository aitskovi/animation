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
	if ((self = [self init])) {
		animation = [animationBlock copy];
	}
	return self;
}

- (void)play {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self.delegate];
	[UIView setAnimationDidStopSelector:@selector(nextAnimation)];
	animation();
	[UIView commitAnimations];
}

- (void)dealloc {
	[animation release];
	[super dealloc];
}
@end
