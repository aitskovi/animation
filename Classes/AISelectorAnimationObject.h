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
	NSArray *arguments;
	
	SEL cSelector;
	id cTarget;
	NSArray *cArguments;
}

@property (nonatomic, retain) id target;
@property (nonatomic) SEL selector;
@property (nonatomic, retain) NSArray *arguments;

@property (nonatomic, retain) id cTarget;
@property (nonatomic) SEL cSelector;
@property (nonatomic, retain) NSArray *cArguments;

- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector;
- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector arguments:(NSArray *)argumentArray;
- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector continuation:(id)continuationTarget continuationSelector:(SEL)continuationSelector;
- (id)initWithTarget:(id)animationTarget selector:(SEL)animationSelector arguments:(NSArray *)argumentArray continuation:(id)continuationTarget continuationSelector:(SEL)continuationSelector continuationArguments:(NSArray *)continuationArguments;
@end
