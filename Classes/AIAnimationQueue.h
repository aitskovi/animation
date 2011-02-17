//
//  AIAnimationQueue.h
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

#import <Foundation/Foundation.h>
#import "AISingleton.h"
#import "AISelectorQueueObject.h"
#import "AIBlockQueueObject.h"

@interface AIAnimationQueue : AISingleton <AIQueueObjectDelegate> {
	NSMutableArray *queue;
	BOOL animating;
}

+ (AIAnimationQueue *)sharedInstance;

// Selector based animations
// Selector is the selector for the lies wrapping the animation
// Target is the object in which that method lies
- (void)addAnimation:(SEL)selector target:(id)target;
- (void)addAnimation:(SEL)selector target:(id)target parameters:(NSArray *)arguments;
- (void)addComputation:(SEL)selector target:(id)target;
- (void)addComputation:(SEL)selector target:(id)target parameters:(NSArray *)arguments;
- (void)addSelector:(SEL)selector target:(id)target parameters:(NSArray *)parameters animation:(BOOL)animation;

// Block based animations
- (void)addAnimation:(void (^)(void))animation;
- (void)addComputation:(void (^)(void))computation;
- (void)addBlock:(void (^)(void))block animation:(BOOL)animation;

// Queue Management
- (void)clear;
- (void)removeObjectsOfType:(Class)classType;
// Returns the number of animations still left in the queue
// A currently running animation does not count as being the queue
- (NSUInteger)count;
- (void)next;

@end
