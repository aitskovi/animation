//
//  AIAnimationQueue.m
//  Animation
//
//  Created by Avi Itskovich on 10-08-07.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import "AIAnimationQueue.h"

@implementation AIAnimationQueue

- (id) init {
	if ((self = [super init])) {
		queue = [[NSMutableArray alloc] initWithCapacity:0];
	}
	return self;
}

- (void)addAnimation:(SEL)selector target:(id)target {
	AIAnimationObject *aObject = [[AIAnimationObject alloc] initWithTarget:target selector:selector];
	aObject.delegate = self;
	[queue addObject:aObject];
	[aObject release];
	if (!animating) {
		[self nextAnimation];
	}
}

- (void)nextAnimation {
	if ([queue count] > 0) {
		AIAnimationObject *animation = [[[queue lastObject] retain] autorelease];
		animating = TRUE;
		[queue removeLastObject];
		[animation play];
		return;
	}
	animating = FALSE;
}

- (void)dealloc {
	[queue release];
	[super dealloc];
}

@end
