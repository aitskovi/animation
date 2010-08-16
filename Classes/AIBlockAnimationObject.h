//
//  AIBlockAnimationObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-08.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AIAnimationObject.h"

@interface AIBlockAnimationObject : AIAnimationObject {
	void(^animation)(void);
	void(^continuation)(void);
}

- (id)initWithBlock:(void (^)(void))animationBlock;
- (id)initWithBlock:(void (^)())animationBlock continuation:(void (^)())continuationBlock;

@end
