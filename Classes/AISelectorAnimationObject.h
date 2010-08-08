//
//  AISelectorAnimationObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-08.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIAnimationObject.h"

@interface AISelectorAnimationObject : AIAnimationObject {
	SEL selector;
	id target;
}

@property (nonatomic, retain) id target;
@property (nonatomic) SEL selector;

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector;

@end
