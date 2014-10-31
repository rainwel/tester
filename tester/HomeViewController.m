//
//  HomeViewController.m
//  tester
//
//  Created by yiliao6 on 22/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "HomeViewController.h"
#import "QuartzCore/QuartzCore.h"

@implementation HomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  animatingOut = YES;

  rotateView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 200)];
  [self.view addSubview:rotateView];

  NSString *strTitle =
      @"Test Title \nI am a test USER!\nHow do you do\nNice Try!!!";
  lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 200)];
  lblTitle.backgroundColor = [UIColor grayColor];
  lblTitle.text = strTitle;
  lblTitle.numberOfLines = 0;
  lblTitle.font = [UIFont boldSystemFontOfSize:30];
  lblTitle.textAlignment = NSTextAlignmentCenter;
  [lblTitle setHidden:YES];
  //  lblTitle.layer.anchorPoint = CGPointMake(0, 0.5);

  //  CALayer *flipLayer2 = [CATransformLayer layer];
  //  flipLayer2.anchorPoint = CGPointMake(0.5, 0);
  //  lblTitle.layer.zPosition = 5;
  [self.view addSubview:lblTitle];

  lblFlip = [[FlipLabel alloc] initWithFrame:CGRectMake(20, 140, 280, 200)];
  lblFlip.backgroundColor = [UIColor grayColor];
  lblFlip.text = strTitle;
  lblFlip.numberOfLines = 0;
  lblFlip.font = [UIFont boldSystemFontOfSize:30];
  lblFlip.textAlignment = NSTextAlignmentCenter;
  lblFlip.layer.anchorPoint = CGPointMake(0.5, 1.0);
  //  lblFlip.layer.doubleSided = NO;
  //  lblFlip.layer.contentsGravity = kCAGravityResizeAspect;

  //  lblFlip.layer.doubleSided = NO;
  //  lblTitle.layer.anchorPoint = CGPointMake(0, 0.5);

  //  CALayer *flipLayer2 = [CATransformLayer layer];
  //  flipLayer2.anchorPoint = CGPointMake(0.5, 0);
  //  lblTitle.layer.zPosition = 5;
  [self.view addSubview:lblFlip];

  NSString *strSubTitle =
      @"Test Title \nI am a test USER!\nHow do you do\nNice Try!!!";
  UILabel *subTitle =
      [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 100)];
  subTitle.backgroundColor = [UIColor grayColor];
  subTitle.text = strSubTitle;
  subTitle.numberOfLines = 0;
  subTitle.font = [UIFont boldSystemFontOfSize:30];
  subTitle.textAlignment = NSTextAlignmentCenter;
  //  subTitle.layer.zPosition = 10;
  //  [self.view addSubview:subTitle];

  [self.view setBackgroundColor:[UIColor whiteColor]];

  btn = [UIButton buttonWithType:UIButtonTypeCustom];

  [btn setBackgroundImage:[[UIImage imageNamed:@"btn_red"]
                              stretchableImageWithLeftCapWidth:20
                                                  topCapHeight:10]
                 forState:UIControlStateNormal];
  [btn setBackgroundImage:[[UIImage imageNamed:@"btn_red_hl"]
                              stretchableImageWithLeftCapWidth:20
                                                  topCapHeight:10]
                 forState:UIControlStateHighlighted];
  //  [btn setImage:[UIImage imageNamed:@"btn_red.png"]
  //       forState:UIControlStateNormal];
  //  [btn setImage:[UIImage imageNamed:@"btn_red_hl.png"]
  //       forState:UIControlStateHighlighted];
  [btn setFrame:CGRectMake(20, 500, 150, 40)];
  [btn setTitle:@"测试一下" forState:UIControlStateNormal];
  [btn addTarget:self
                action:@selector(clickBtn)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn];

  testView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
  [testView setBackgroundColor:[UIColor redColor]];
  [self.view addSubview:testView];
}

- (void)viewDidAppear:(BOOL)animated {

  [super viewDidAppear:animated];
}

- (void)clickBtn {

  NSInteger height = CGRectGetHeight(self.view.bounds);
  NSInteger width = CGRectGetWidth(self.view.bounds);

  CGFloat centerX = arc4random() % width;
  CGFloat centerY = arc4random() % height;

  POPSpringAnimation *smoveAnim =
      [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];

  smoveAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
  smoveAnim.springBounciness = 6;
  smoveAnim.springSpeed = 3;
  [testView pop_addAnimation:smoveAnim forKey:@"springMove"];

  /*POPBasicAnimation *moveAnim =
      [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
  moveAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
  moveAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
  moveAnim.duration = 0.4;
  [testView pop_addAnimation:moveAnim forKey:@"centerAnimation"];*/

  POPSpringAnimation *rotateAnim =
      [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
  rotateAnim.toValue = @(M_PI * (arc4random() % 4 + 1));
  rotateAnim.beginTime = CACurrentMediaTime() + 0.1;
  rotateAnim.springBounciness = 8;
  //  rotateAnim.springSpeed = 4;
  rotateAnim.completionBlock = ^(POPAnimation *anim, BOOL bFinished) {
      NSLog(@"Rotation is Done! %d", bFinished ? 1 : 0);
  };
  /*Point newVelocity =
      Point((arc4random() % 10) / 10.0, (arc4random() % 10) / 10.0);
  rotateAnim.velocity = [NSValue valueWithCGPoint:newVelocity];*/
  [testView.layer pop_addAnimation:rotateAnim forKey:@"rotationAnim"];

  POPBasicAnimation *basicAnim =
      [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
  //  float newAlpha = (arc4random() % 4) / 4.0 + 0.1;
  basicAnim.toValue = @((arc4random() % 4) / 4.0 + 0.1);
  //[NSNumber numberWithFloat:newAlpha];

  basicAnim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
  basicAnim.duration = 0.4;
  [testView.layer pop_addAnimation:basicAnim forKey:@"alphaAnimation"];

  [self performTitleAnimate];
}

- (void)performTitleAnimate {

  POPAnimatableProperty *animatableProperty = [POPAnimatableProperty
      propertyWithName:@"com.rain.transFactor"
           initializer:^(POPMutableAnimatableProperty *prop) {
               prop.writeBlock = ^(id obj, const CGFloat values[]) {
                   [obj setTransFactor:values[0]];
               };
               prop.readBlock = ^(id obj, CGFloat values[]) {
                   values[0] = [obj getTransFactor];
               };
           }];
  POPSpringAnimation *testAnim = [POPSpringAnimation animation];
  testAnim.property = animatableProperty;
//  testAnim.springBounciness = 10.0;
//  testAnim.springSpeed = 6;
  testAnim.fromValue = @(0.0);
  testAnim.toValue = @(-M_PI);
  //  testAnim.velocity = [NSValue valueWithCGPoint:CGPointMake(0.50, 0.2)];
  //  testAnim.timingFunction =
  //      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
  //  testAnim.dynamicsMass = 5;
  [lblFlip pop_addAnimation:testAnim forKey:@"easeOut"];

  [lblTitle pop_removeAllAnimations];
  CATransform3D aTransform = CATransform3DIdentity;
  aTransform.m34 = 1.0 / -200;

  //  POPBasicAnimation *sanim =
  //      [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
  //  NSValue *val = [NSValue
  //      valueWithCATransform3D:CATransform3DRotate(aTransform, 0.0, 1, 0, 0)];
  //
  //  sanim.fromValue = [NSValue
  //      valueWithCATransform3D:CATransform3DRotate(aTransform, 0.0, 1, 0, 0)];
  //  sanim.toValue = [NSValue
  //      valueWithCATransform3D:CATransform3DRotate(aTransform, -M_PI, 1, 0,
  //      0)];
  //
  //  [lblTitle.layer pop_addAnimation:sanim forKey:@"sanim"];

  //  CABasicAnimation *anim = [CABasicAnimation
  //  animationWithKeyPath:@"transform"];
  //  anim.duration = 1.0;
  //  anim.fromValue = [NSValue
  //      valueWithCATransform3D:CATransform3DRotate(aTransform, 0.0, 1, 0, 0)];
  //  anim.toValue = [NSValue
  //      valueWithCATransform3D:CATransform3DRotate(aTransform, -M_PI, 1, 0,
  //      0)];
  //  anim.removedOnCompletion = NO;
  //  [anim setFillMode:kCAFillModeForwards];
  //
  //  //  [lblTitle.layer addAnimation:anim forKey:@"transformAnimation"];
  //
  //  lblTitle.layer.transform =
  //      CATransform3DRotate(aTransform, -M_PI / 4, 1, 0, 0);

  CGSize titleSize = [lblTitle bounds].size;
  //
  //  CALayer *flipLayer = [CATransformLayer layer];
  //  flipLayer.frame = CGRectMake(0, titleSize.height / 4, titleSize.width,
  //                               titleSize.height / 2);
  //  flipLayer.anchorPoint = CGPointMake(0.5, 1.0);
  //  [flipLayer addSublayer:lblTitle.layer];
  //    CGRect layerRect = CGRectMake(0,
  //                                  0,
  //                                  titleSize.width,
  //                                  titleSize.height/2);

  //    CALayer *backLayer = [self layerWithFrame:layerRect
  //    contentGravity:kCAGravityTop cornerRadius:sublayerCornerRadius
  //    doubleSided:NO];
  //    [flipLayer addSublayer:backLayer];

  //  POPBasicAnimation *rotateAnim =
  //      [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
  //  rotateAnim.fromValue = @0;
  //  rotateAnim.toValue = @-M_PI;
  //  rotateAnim.duration = 1;
  //  [flipLayer pop_addAnimation:rotateAnim forKey:@"pop"];

  //    POPBasicAnimation *rotateAnim = [POPBasicAnimation
  //    animationWithPropertyNamed:kPOPLayerRotationX];
  //    rotateAnim.fromValue = @0;
  //    rotateAnim.toValue = @1.9;
  //    rotateAnim.duration = 1;
  //
  //    [btn.layer pop_addAnimation:rotateAnim forKey:@"key"];

  //  POPSpringAnimation *degreeAnim =
  //      [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
  //  degreeAnim.springBounciness = 8.0f;
  //  degreeAnim.springSpeed = 4;
  //  degreeAnim.dynamicsMass = 4.0f;
  //  degreeAnim.fromValue = @(M_PI_4); //@(degreesToRadians(degrees));
  //  degreeAnim.toValue = @(M_PI);
  //  [btn.layer pop_addAnimation:degreeAnim forKey:@"rotationXAnimation"];

  //  POPBasicAnimation *rAnim =
  //      [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
  //  rAnim.fromValue = @0;
  //  rAnim.toValue = @3.0;
  //  rAnim.duration = 4;
  //  [lblTitle.layer pop_addAnimation:rAnim forKey:@"rotationXAnimation"];

  return;

  CGRect largeRect = (CGRect){CGPointMake(1.5, 1.5), CGSizeZero};

  //  CGRect largeRect = CGRectMake(1.5, 1.5, 0, 0);
  CGRect smallRect = CGRectMake(1.0, 1.0, 0, 0);

  POPSpringAnimation *animation =
      [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
  animation.springBounciness = 6;
  animation.springSpeed = 1.5;

  if (animatingOut) {
    animation.toValue = [NSValue valueWithCGRect:largeRect];
    animatingOut = NO;
  } else {
    animation.toValue = [NSValue valueWithCGRect:smallRect];
    animatingOut = YES;
  }

  /*POPSpringAnimation *animation =
   [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
   CGRect largeRect = CGRectMake(0, 0, 300, 80);
   animation.toValue = [NSValue valueWithCGRect:largeRect];
   animation.springBounciness = 6;
   animation.springSpeed = 1.5;*/
  [lblTitle pop_addAnimation:animation forKey:@"size"];
}

@end
