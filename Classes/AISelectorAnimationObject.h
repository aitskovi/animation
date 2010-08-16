//
//  AISelectorAnimationObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-08.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AIAnimationObject.h"

@interface AISelectorAnimationObject : AIAnimationObject {
	SEL selector;
	id target;
	
	SEL cSelector;
	id cTarget;
}

@property (nonatomic, retain) id target;
@property (nonatomic) SEL selector;
@property (nonatomic, retain) id cTarget;
@property (nonatomic) SEL cSelector;

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector;
- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector continuation:(id)continuationTarget continuationSelector:(SEL)continuationSelector;
@end
