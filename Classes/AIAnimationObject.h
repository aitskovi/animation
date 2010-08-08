//
//  AIAnimationObject.h
//  Animation
//
//  Created by Avi Itskovich on 10-08-07.
//  Copyright 2010 Avi Itskovich. All rights reserved.
//
//  Permission is given to use this source code file without charge in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <Foundation/Foundation.h>


@protocol AIAnimationObjectDelegate

@required
- (void)nextAnimation;

@end

@interface AIAnimationObject : NSObject {
	id <AIAnimationObjectDelegate> delegate;
}

@property (nonatomic, assign) id delegate;

- (void)play;
@end
