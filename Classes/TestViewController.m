//
//  TestViewController.m
//  animation
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

#import "TestViewController.h"
#import "AIAnimationQueue.h"

@implementation TestViewController

- (id)init {
	return [self initWithNibName:@"TestViewController" bundle:[NSBundle mainBundle]];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	// EXAMPLE: Queuing Animations
	
	// Add a label that will be moved for testing
	label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
	label.text = @"Test";
	[self.view addSubview:label];
	[self selectorTests];
	[self selectorWithContinuationTests];
	[self selectorWithArgumentsTests];
	#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
	[self blockTests];
	[self blocksWithContinuationTests];
	# endif
}

- (void)selectorTests {
	NSLog(@"=== Selector Tests ===");
	AIAnimationQueue *animationQueue = [AIAnimationQueue sharedInstance];
	
	// Animations with Selectors (iOS 3.2 and lower)
	[animationQueue addAnimation:@selector(moveDown) target:self];
	[animationQueue addAnimation:@selector(moveRight) target:self];
	[animationQueue addAnimation:@selector(moveUp) target:self];
	[animationQueue addAnimation:@selector(moveLeft) target:self];
	[animationQueue addAnimation:@selector(samePlace) target:self];	
}

- (void)selectorWithContinuationTests {
	NSLog(@"=== Selector With Continuation Tests ===");
	AIAnimationQueue *animationQueue = [AIAnimationQueue sharedInstance];
	
	// Animations with Selectors and Continuations (iOS 3.2 and lower)
	[animationQueue addAnimation:@selector(moveDown) target:self];
	[animationQueue addComputation:@selector(downContinuation) target:self];
	
	[animationQueue addAnimation:@selector(moveRight) target:self];
	[animationQueue addComputation:@selector(rightContinuation) target:self];
	
	[animationQueue addAnimation:@selector(moveUp) target:self];
	[animationQueue addComputation:@selector(upContinuation)	target:self];
	
	[animationQueue addAnimation:@selector(moveLeft) target:self];
	[animationQueue addComputation:@selector(leftContinuation)	target:self];
	
	[animationQueue addAnimation:@selector(samePlace) target:self];
	[animationQueue addComputation:@selector(samePlaceContinuation)	target:self];
}

- (void)selectorWithArgumentsTests {
	NSLog(@"=== Selector With Arguments Tests ===");
	AIAnimationQueue *animationQueue = [AIAnimationQueue sharedInstance];
	
	NSValue *rect = [NSValue valueWithCGRect:CGRectMake(0, 400, 100, 40)];
	NSArray *parameters = [NSArray arrayWithObject:rect];
	[animationQueue addAnimation:@selector(moveTo:) target:self parameters:parameters];
	
	rect = [NSValue valueWithCGRect:CGRectMake(220, 400, 100, 40)];
	parameters = [NSArray arrayWithObject:rect];
	[animationQueue addAnimation:@selector(moveTo:) target:self parameters:parameters];
	
	rect = [NSValue valueWithCGRect:CGRectMake(220, 0, 100, 40)];
	parameters = [NSArray arrayWithObject:rect];
	[animationQueue addAnimation:@selector(moveTo:) target:self parameters:parameters];
	
	rect = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 40)];
	parameters = [NSArray arrayWithObject:rect];
	[animationQueue addAnimation:@selector(moveTo:) target:self parameters:parameters];
	
	rect = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 40)];
	parameters = [NSArray arrayWithObject:rect];
	[animationQueue addAnimation:@selector(moveTo:) target:self parameters:parameters];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
- (void)blockTests {
	NSLog(@"=== Block Tests ===");
	AIAnimationQueue *animationQueue = [AIAnimationQueue sharedInstance];
	
	// Animations with Blocks (iOS 4.0 +)
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(0, 400, 100, 40); 
	}];
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(220, 400, 100, 40); 
	}];
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(220, 0, 100, 40); 
	}];
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(0, 0, 100, 40); 
	}];
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = label.frame; 
	}];
}

- (void)blocksWithContinuationTests {
	NSLog(@"=== Blocks with Continuation Tests ===");
	AIAnimationQueue *animationQueue = [AIAnimationQueue sharedInstance];
	
	// Animations with Blocks and Continuations (iOS 4.0 +)
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(0, 400, 100, 40); 
	}];
	[animationQueue addComputation: ^{ 
		NSLog(@"Done 1"); 
	}];
	
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(220, 400, 100, 40); 
	}];
	[animationQueue addComputation: ^{ 
		NSLog(@"Done 2"); 
	}];
	
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(220, 0, 100, 40); 
	}];
	[animationQueue addComputation: ^{ 
		NSLog(@"Done 3"); 
	}];
	
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(0, 0, 100, 40); 
	}];
	[animationQueue addComputation: ^{ 
		NSLog(@"Done 4"); 
	}];
	
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = label.frame; 
	}];
	[animationQueue addComputation: ^{ 
		NSLog(@"Done 5"); 
	}];
}
#endif

- (void)moveTo:(NSValue *)rect {
	[UIView setAnimationDuration:2.0];
	label.frame = [rect CGRectValue];
}

- (void)moveDown {
	[UIView setAnimationDuration:2.0];
	label.frame = CGRectMake(0, 400, 100, 40);
}

- (void)downContinuation {
	NSLog(@"Done down animation");
}

- (void)moveRight {
	[UIView setAnimationDuration:2.0];
	label.frame = CGRectMake(220, 400, 100, 40);
}

- (void)rightContinuation {
	NSLog(@"Done right animation");
}

- (void)moveUp {
	[UIView setAnimationDuration:2.0];
	label.frame = CGRectMake(220, 0, 100, 40);
}

- (void)upContinuation {
	NSLog(@"Done up animation");
}

- (void)moveLeft {
	[UIView setAnimationDuration:2.0];
	label.frame = CGRectMake(0, 0, 100, 40);
}

- (void)leftContinuation {
	NSLog(@"Done left animation");
}

- (void)samePlace {
	[UIView setAnimationDuration:2.0];
	label.frame = label.frame;
}

- (void)samePlaceContinuation {
	NSLog(@"Done same place test");
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[label release];
    [super dealloc];
}


@end
