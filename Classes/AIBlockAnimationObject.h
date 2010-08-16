//
//  AIBlockAnimationObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-08.
//  Copyright 2010 Avi Itskovich. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
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
