//
//  CubeViewController.m
//  tester
//
//  Created by yiliao6 on 29/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "CubeViewController.h"

@implementation CubeViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  curIndex = 0;
  imgView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic0.jpg"]];
  imgView.frame = [UIScreen mainScreen].applicationFrame;
  imgView.contentMode = UIViewContentModeScaleAspectFit;
  [self.view addSubview:imgView];

  UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [btnLeft setTitle:@"Prev" forState:UIControlStateNormal];
  btnLeft.frame = CGRectMake(20, 20, 80, 40);
  [btnLeft addTarget:self
                action:@selector(leftSwipe)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btnLeft];

  UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [btnRight setTitle:@"Next" forState:UIControlStateNormal];
  btnRight.frame = CGRectMake(220, 20, 80, 40);
  [btnRight addTarget:self
                action:@selector(rightSwipe)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btnRight];

  //  UISwipeGestureRecognizer *leftSwipe =
  //      [[UISwipeGestureRecognizer alloc] initWithTarget:self
  //                                                action:@selector(leftSwipe:)];
  //  leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
  //  [imgView addGestureRecognizer:leftSwipe];
  //
  //  UISwipeGestureRecognizer *rightSwipe =
  //      [[UISwipeGestureRecognizer alloc] initWithTarget:self
  //                                                action:@selector(rightSwipe:)];
  //  rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
  //  [imgView addGestureRecognizer:rightSwipe];
}

- (void)leftSwipe {
  [self transImageAnimation:NO];
}

- (void)rightSwipe {
  [self transImageAnimation:YES];
}

- (void)transImageAnimation:(BOOL)bNext {
  CATransition *trans = [[CATransition alloc] init];
  trans.type = @"cube";
  trans.subtype = bNext ? kCATransitionFromRight : kCATransitionFromLeft;
  imgView.image = [self getImage:bNext];
  [imgView.layer addAnimation:trans forKey:@"cubeTrans"];
}

- (UIImage *)getImage:(BOOL)bNext {
  if (bNext) {
    curIndex = (curIndex + 1) % 6;
  } else {
    curIndex = (curIndex - 1 + 6) % 6;
  }
  NSString *name = [NSString stringWithFormat:@"pic%i.jpg", curIndex];
  return [UIImage imageNamed:name];
}

@end
