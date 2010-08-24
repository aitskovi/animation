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

#pragma mark -
#pragma mark Selector Animations

- (void)addAnimation:(SEL)selector target:(id)target {
	[self addAnimation:selector target:target continuation:nil continuationTarget:nil];
}

- (void)addAnimation:(SEL)selector target:(id)target continuation:(SEL)cSelector continuationTarget:(id)cTarget {
	AISelectorAnimationObject *aObject = [[AISelectorAnimationObject alloc] initWithTarget:target selector:selector continuation:cTarget continuationSelector:cSelector];
	aObject.delegate = self;
	[queue addObject:aObject];
	[aObject release];
	if (!animating) {
		[self nextAnimation];
	}
}

- (void)addAnimation:(SEL)selector target:(id)target arguments:(NSArray *)arguments {
	AISelectorAnimationObject *aObject = [[AISelectorAnimationObject alloc] initWithTarget:target selector:selector arguments:arguments];
	aObject.delegate = self;
	[queue addObject:aObject];
	[aObject release];
	if (!animating) {
		[self nextAnimation];
	}
}

#pragma mark -
#pragma mark Block Animations

- (void)addAnimation:(void (^)(void))animation {
	[self addAnimation:animation continuation:nil];
}

- (void)addAnimation:(void (^)())animation continuation:(void (^)())continuation {
	AIBlockAnimationObject *aObject = [[AIBlockAnimationObject alloc] initWithBlock:animation continuation:continuation];
	aObject.delegate = self;
	[queue addObject:aObject];
	[aObject release];
	if (!animating) {
		[self nextAnimation];
	}
}

#pragma mark -
#pragma mark Queue Management

- (void)nextAnimation {
	if ([queue count] > 0) {
		AIAnimationObject *animation = [[[queue objectAtIndex:0] retain] autorelease];
		
		// Set boolean and remove before playing because animations where nothing happens
		// occur instantaneously causing an infinited loop if these are set after play
		// is called
		animating = TRUE;
		[queue removeObjectAtIndex:0];
		
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
