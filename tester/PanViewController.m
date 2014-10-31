//
//  PanViewController.m
//  tester
//
//  Created by yiliao6 on 24/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "PanViewController.h"
#import <POP.h>

@implementation PanViewController
- (void)viewDidLoad {
  [super viewDidLoad];

  vbox = [[UIView alloc] initWithFrame:CGRectMake(60, 100, 60, 60)];
  vbox.backgroundColor = [UIColor greenColor];
  [self.view addSubview:vbox];

  UIPanGestureRecognizer *panGesture =
      [[UIPanGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(playbox:)];
  [panGesture setMaximumNumberOfTouches:1];
  [panGesture setMinimumNumberOfTouches:1];

  [vbox addGestureRecognizer:panGesture];
}

- (void)playbox:(UIPanGestureRecognizer *)recognizer {
  CGPoint velocity = [recognizer velocityInView:self.view];
  /*POPSpringAnimation *anim =
      [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
  anim.velocity = [NSValue valueWithCGPoint:velocity];
  [vbox.layer pop_addAnimation:anim forKey:@"rate"];*/

  POPSpringAnimation *positionAnimation =
      [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
  positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
  //  positionAnimation.dynamicsTension = 5;
  //  positionAnimation.dynamicsFriction = 5.0f;
  positionAnimation.springBounciness = 4.0f;
  positionAnimation.springSpeed = 2;
  [vbox pop_addAnimation:positionAnimation forKey:@"positionAnimation"];

  POPSpringAnimation *sizeAnimation =
      [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
  sizeAnimation.velocity = [NSValue valueWithCGPoint:velocity];
  sizeAnimation.springBounciness = 1.0f;
  sizeAnimation.dynamicsFriction = 1.0f;
  [vbox pop_addAnimation:sizeAnimation forKey:@"sizeAnimation"];
}

@end
