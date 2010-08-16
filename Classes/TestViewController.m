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
	
	// The animation queue is a singleton that prevails through the whole project
	AIAnimationQueue *animationQueue = [AIAnimationQueue sharedInstance];
	
	// Animations with Selectors (iOS 3.2 and lower)
	[animationQueue addAnimation:@selector(moveDown) target:self];
	[animationQueue addAnimation:@selector(moveRight) target:self];
	[animationQueue addAnimation:@selector(moveUp) target:self];
	[animationQueue addAnimation:@selector(moveLeft) target:self];
	[animationQueue addAnimation:@selector(samePlace) target:self];
	
	// Animations with Selectors and Continuations (iOS 3.2 and lower)
	[animationQueue addAnimation:@selector(moveDown) target:self continuation:@selector(downContinuation) continuationTarget:self];
	[animationQueue addAnimation:@selector(moveRight) target:self continuation:@selector(rightContinuation) continuationTarget:self];
	[animationQueue addAnimation:@selector(moveUp) target:self continuation:@selector(upContinuation) continuationTarget:self];
	[animationQueue addAnimation:@selector(moveLeft) target:self continuation:@selector(leftContinuation) continuationTarget:self];
	[animationQueue addAnimation:@selector(samePlace) target:self continuation:@selector(samePlaceContinuation) continuationTarget:self];
	
	
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
	
	// Animations with Blocks and Continuations (iOS 4.0 +)
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(0, 400, 100, 40); 
	} continuation:^{ 
		NSLog(@"Done 1"); 
	}];
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(220, 400, 100, 40); 
	} continuation:^{ 
		NSLog(@"Done 2"); 
	}];
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(220, 0, 100, 40); 
	} continuation:^{ 
		NSLog(@"Done 3"); 
	}];
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = CGRectMake(0, 0, 100, 40); 
	} continuation:^{ 
		NSLog(@"Done 4"); 
	}];
	[animationQueue addAnimation:^{ 
		[UIView setAnimationDuration:2.0];
		label.frame = label.frame; 
	} continuation:^{ 
		NSLog(@"Done 5"); 
	}];
	
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
