//
//  AIBlockQueueObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-24.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIQueueObject.h"

@interface AIBlockQueueObject : AIQueueObject {
	void(^block)(void);
	BOOL animated; 
}

- (id)initWithAnimation:(void (^)(void))animation;
- (id)initWithComputation:(void (^)(void))computation;
- (id)initWithBlock:(void (^)(void))aBlock;

@end
