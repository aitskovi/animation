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
#import "AISelectorAnimationObject.h"
#import "AIBlockAnimationObject.h"

@interface AIAnimationQueue : AISingleton <AIAnimationObjectDelegate> {
	NSMutableArray *queue;
	BOOL animating;
}

+ (AIAnimationQueue *)sharedInstance;

// Selector based animations
// Selector is the selector for the lies wrapping the animation
// Target is the object in which that method lies
- (void)addAnimation:(SEL)selector target:(id)target;
- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector arguments:(NSArray *)argumentArray;
- (void)addAnimation:(SEL)selector target:(id)target continuation:(SEL)cSelector continuationTarget:(id)cTarget;

// Block based animations
- (void)addAnimation:(void (^)(void))animation;
- (void)addAnimation:(void (^)())animation continuation:(void (^)())continuation;

- (void)nextAnimation;

@end
