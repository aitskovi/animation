//
//  AIAnimationQueue.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-07.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AISingleton.h"
#import "AIAnimationObject.h"

@interface AIAnimationQueue : AISingleton <AIAnimationObjectDelegate> {
	NSMutableArray *queue;
	BOOL animating;
}

- (void)addAnimation:(SEL)selector target:(id)target;
- (void)nextAnimation;

@end
