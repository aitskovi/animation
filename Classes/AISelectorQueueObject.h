//
//  AISelectorQueueObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-24.
//  Copyright 2010 Bloq Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIQueueObject.h"

@interface AISelectorQueueObject : AIQueueObject {
	SEL selector;
	id target;
	NSArray *parameters;
	BOOL animation;
}

@property (nonatomic) SEL selector;
@property (nonatomic, retain) id target;
@property (nonatomic, retain) NSArray *paremeters;

- (id)initWithAnimation:(SEL)aSelector target:(id)aTarget arguments:(NSArray *)argumentArray;
- (id)initWithComputation:(SEL)aSelector target:(id)aTarget arguments:(NSArray *)argumentArray;
- (id)initWithSelector:(SEL)aSelector target:(id)aTarget arguments:(NSArray *)parementerArray;

- (void)performSelector;

@end
