//
//  AIBlockAnimationObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-08.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIAnimationObject.h"

@interface AIBlockAnimationObject : AIAnimationObject {
	void(^animation)(void);
}

- (id)initWithBlock:(void (^)(void))animationBlock;

@end
