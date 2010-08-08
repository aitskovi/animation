//
//  AIAnimationQueue.m
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

#import "AIAnimationQueue.h"

@implementation AIAnimationQueue

+ (AIAnimationQueue *)sharedInstance {
	return (AIAnimationQueue *)[super sharedInstance];
}

- (id) init {
	if ((self = [super init])) {
		queue = [[NSMutableArray alloc] init];
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
		
		// Set boolean and remove before playing because animations where nothing happens
		// occur instantaneously causing an infinited loop if these are set after play
		// is called
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
