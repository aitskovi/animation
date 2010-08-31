AIAnimationQueue
================

An animation queue for UIView animations in Objective C

Overview
--------

AIAnimationQueue is a singleton that allows sequencing of code execution. AIAnimationQueue supports adding both animations and computations to the queue. The actions added to the queue will be performed sequentially. AIAnimationQueue supports passing code packed in both method and block forms. In addition, it also supports using arguments when passing a method (selector). Computation can be queued and used in exchange for losing the right to specify a didStopSelector in the animation.

Instructions
------------

Packing the Animation/Computation:
When packing the animation make sure to leave out
	[UIView beginAnimation:(NSString *)animationID context:(void *)context];
	[UIView setAnimationDelegate:(id)target];
	[UIView setAnimationDidStopSelector:(SEL)selector];
	[UIView commitAnimation];

You should end-up with something like this:	
	- (void)animation {
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(0,0,0,0);
	}
or in block form:
	void(^block)(void) = : {
		[UIView setAnimationDuration:2.0];
		[label.frame = CGRectMake(0,0,0,0)];
	}

Getting the AIAnimationQeue object:

	AIAnimationQueue *aQueue = [AIAnimationQueue sharedInstance];

Adding a selector-based animation:
	
	SEL selector = @selector(animation);
	id target = self;
	[aQueue addAnimation:selector target:target];

Adding a block-based animation
	void(^block)(void) = animation;
	[aQueue addAnimation:block];

Computations are added in much the same way except instead of using the addAnimation methods you would use the addComputation methods which accept the same parameters. AIAnimationQueue also supports passing parametrized selectors with examples available in TestViewController.m.

Compatibility
-------------
* AIAnimationQueue supports only selector based animations and computations in iOS 3.2 and lower
* AIAnimationQueue supports both selector based and block based animations and computations in iOS 4.0+

