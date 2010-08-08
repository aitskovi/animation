//
//  AIAnimationObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-07.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AIAnimationObjectDelegate

@required
- (void)nextAnimation;

@end

@interface AIAnimationObject : NSObject {
	id <AIAnimationObjectDelegate> delegate;
	SEL selector;
	id target;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) id target;
@property (nonatomic) SEL selector;

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector;
- (void)play;
@end
