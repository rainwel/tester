//
//  MaskViewController.m
//  tester
//
//  Created by yiliao6 on 30/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "MaskViewController.h"

#define degreesToRadians(degrees) ((degrees) / 180.0 * M_PI)
#define radiansToDegrees(radians) ((radians) * (180.0 / M_PI))

@implementation MaskViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  curAngle = 90;
  isLoading = NO;
  self.view.backgroundColor = [UIColor colorWithRed:220.0 / 255.0
                                              green:220.0 / 255.0
                                               blue:220.0 / 255.0
                                              alpha:0.8];
  [self addMaskImages1];
  [self addMaskImages2];
  [self addMaskImages3];
  [self addMaskImages4];
  [self addMaskImages5];
  [self addMaskImages6];

  UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [btn setTitle:@"test" forState:UIControlStateNormal];
  btn.frame = CGRectMake(210, 20, 80, 40);
  [btn addTarget:self
                action:@selector(clickBtn)
      forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:btn];
}

- (void)addMaskImages1 {
  CAShapeLayer *mskLayer = [[CAShapeLayer alloc] init];
  mskLayer.path = [self pathFromSize:CGSizeMake(150, 150)];
  mskLayer.fillColor = [UIColor blackColor].CGColor;
  mskLayer.borderColor = [UIColor blackColor].CGColor;
  mskLayer.borderWidth = 4;

  UIImageView *imgView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
  imgView.layer.mask = mskLayer;
  imgView.clipsToBounds = YES;
  imgView.frame = CGRectMake(10, 20, 200, 200);
  imgView.layer.borderColor = [UIColor blackColor].CGColor;
  imgView.layer.borderWidth = 4;

  [self.view addSubview:imgView];
}

- (void)addMaskImages2 {
  //    UIBezierPath *layerPath =
  //    [UIBezierPath bezierPathWithOvalInRect:CGRectMake(1, 1, 120, 90)];

  NSArray *array2 = [[NSArray alloc]
      initWithObjects:[NSValue valueWithCGPoint:CGPointMake(20, 20)],
                      [NSValue valueWithCGPoint:CGPointMake(80, 10)],
                      [NSValue valueWithCGPoint:CGPointMake(110, 60)],
                      [NSValue valueWithCGPoint:CGPointMake(50, 100)],
                      [NSValue valueWithCGPoint:CGPointMake(10, 70)], nil];

  CAShapeLayer *mskLayer = [[CAShapeLayer alloc] init];
  mskLayer.path = [self pathFromPoints:array2];
  mskLayer.fillColor = [UIColor blackColor].CGColor;
  mskLayer.borderColor = [UIColor blackColor].CGColor;
  mskLayer.borderWidth = 4;

  UIImageView *imgView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
  imgView.layer.mask = mskLayer;
  imgView.clipsToBounds = YES;
  imgView.frame = CGRectMake(10, 230, 200, 200);
  imgView.layer.borderColor = [UIColor blackColor].CGColor;
  imgView.layer.borderWidth = 4;

  [self.view addSubview:imgView];
}

- (void)addMaskImages3 {

  CAGradientLayer *mskLayer = [[CAGradientLayer alloc] init];
  mskLayer.colors = [NSArray
      arrayWithObjects:
          (id)[UIColor blackColor].CGColor,
          (id)[UIColor colorWithRed : .0 green : .0 blue : 1.0 alpha : 0.0]
              .CGColor,
          nil];
  mskLayer.frame = CGRectMake(0, 0, 200, 200);

  UIImageView *imgView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
  imgView.layer.mask = mskLayer;
  imgView.clipsToBounds = YES;
  imgView.frame = CGRectMake(10, 350, 200, 200);

  [self.view addSubview:imgView];
}

- (void)addMaskImages4 {

  UIImage *img = [UIImage imageNamed:@"pattern.png"];

  CALayer *mskLayer = [[CALayer alloc] init];
  mskLayer.frame = CGRectMake(0, 0, 120, 120);
  mskLayer.contents = (id)img.CGImage;

  UIImageView *imgView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
  imgView.layer.mask = mskLayer;
  imgView.clipsToBounds = YES;
  imgView.contentMode = UIViewContentModeScaleAspectFit;
  imgView.frame = CGRectMake(180, 20, 200, 200);

  [self.view addSubview:imgView];
}

- (void)addMaskImages5 {

  loadingMaskLayer = [[CAShapeLayer alloc] init];
  loadingMaskLayer.path = [self pathOfSector:CGPointMake(90, 90) radius:60];

  imgLoading =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
  imgLoading.layer.mask = loadingMaskLayer;
  imgLoading.clipsToBounds = YES;

  imgLoading.frame = CGRectMake(110, 170, 200, 200);

  [self.view addSubview:imgLoading];
}

- (void)addMaskImages6 {

  UIBezierPath *circlePath =
      [UIBezierPath bezierPathWithOvalInRect:CGRectMake(90, 100, 100, 100)];
  UIBezierPath *innerCirclePath =
      [UIBezierPath bezierPathWithOvalInRect:CGRectMake(40, 110, 80, 80)];
  [circlePath appendPath:innerCirclePath];
  //  [circlePath setUsesEvenOddFillRule:YES]; //后便会有说明
  //  [circlePath addClip];

  CAShapeLayer *cslayer = [[CAShapeLayer alloc] init];
  cslayer.path = circlePath.CGPath;

  UIImageView *imgView =
      [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
  imgView.layer.mask = cslayer;
  imgView.clipsToBounds = YES;

  imgView.frame = CGRectMake(120, 350, 200, 200);

  [self.view addSubview:imgView];
}

- (CGPathRef)pathFromSize:(CGSize)size {
  int iRadius = 8;
  int iSide4 = 12;
  int iSide3 = 9;
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:CGPointMake(iRadius * 2, iRadius)];
  [path addLineToPoint:CGPointMake(size.width - iRadius * 2 - iSide4, iRadius)];

  //  [path addArcWithCenter:CGPointMake(size.width - iRadius * 2 - iSide4,
  //                                     iRadius * 2)
  //                  radius:iRadius
  //              startAngle:M_PI_2
  //                endAngle:0
  //               clockwise:YES];
  [path addLineToPoint:CGPointMake(size.width - iRadius - iSide4, iRadius * 2)];
  [path addLineToPoint:CGPointMake(size.width - iRadius - iSide4,
                                   iRadius * 2 + 20)];

  [path addLineToPoint:CGPointMake(size.width - iRadius, iRadius * 2 + 20 + 6)];

  [path addLineToPoint:CGPointMake(size.width - iRadius,
                                   iRadius * 2 + 20 + iSide3 * 2 - 6)];

  //  [path addLineToPoint:CGPointMake(size.width - iRadius,
  //                                   iRadius * 2 + 20 + iSide3)];

  [path addLineToPoint:CGPointMake(size.width - iRadius - iSide4,
                                   iRadius * 2 + 20 + iSide3 * 2)];

  [path addLineToPoint:CGPointMake(size.width - iRadius - iSide4,
                                   size.height - iRadius * 2)];

  [path addArcWithCenter:CGPointMake(size.width - iRadius * 2 - iSide4,
                                     size.height - iRadius * 2)
                  radius:iRadius
              startAngle:0
                endAngle:M_PI_2
               clockwise:YES];
  [path addLineToPoint:CGPointMake(iRadius * 2, size.height - iRadius)];
  [path addArcWithCenter:CGPointMake(iRadius * 2, size.height - iRadius * 2)
                  radius:iRadius
              startAngle:M_PI_2
                endAngle:M_PI
               clockwise:YES];
  [path addLineToPoint:CGPointMake(iRadius, iRadius * 2)];
  [path addArcWithCenter:CGPointMake(iRadius * 2, iRadius * 2)
                  radius:iRadius
              startAngle:M_PI
                endAngle:M_PI_2
               clockwise:YES];

  [path closePath];

  UIBezierPath *rtCircle = [UIBezierPath
      bezierPathWithOvalInRect:CGRectMake(size.width - iRadius * 3 - iSide4,
                                          iRadius, iRadius * 2, iRadius * 2)];
  [path appendPath:rtCircle];

  UIBezierPath *angleCircle = [UIBezierPath
      bezierPathWithOvalInRect:CGRectMake(size.width - iRadius - 4,
                                          iRadius * 2 + 20 + 6, 6, 6)];
  [path appendPath:angleCircle];

  return CGPathCreateCopy(path.CGPath);
}

- (CGPathRef)pathFromPoints:(NSArray *)points {
  UIBezierPath *path = [UIBezierPath bezierPath];
  [path moveToPoint:[[points objectAtIndex:0] CGPointValue]];

  NSInteger count = points.count;
  for (NSInteger i = 1; i < count; i++) {

    CGPoint poNext = [[points objectAtIndex:i] CGPointValue];
    [path addLineToPoint:poNext];

    //    [path addCurveToPoint:po
    //            controlPoint1:CGPointMake(po.x - 10, po.y - 10)
    //            controlPoint2:CGPointMake(po.x - 10, po.y - 10)];

    //    [path addArcWithCenter:CGPointMake(poPrev.x/2 + po.x/2, poPrev.y/2 +
    //    po.y/2)
    //                    radius:80
    //                startAngle:0
    //                  endAngle:M_PI_2
    //                 clockwise:YES];
  }
  [path closePath];

  return CGPathCreateCopy(path.CGPath);
}

- (CGPathRef)pathOfSector:(CGPoint)posCenter radius:(float)radius {
  UIBezierPath *path =
      [UIBezierPath bezierPathWithArcCenter:posCenter
                                     radius:radius
                                 startAngle:-degreesToRadians(90)
                                   endAngle:-degreesToRadians(curAngle)
                                  clockwise:YES];
  [path addLineToPoint:posCenter];
  [path closePath];
  return CGPathCreateCopy(path.CGPath);
}

- (void)clickBtn {
  if (isLoading) {
    return;
  }
  isLoading = YES;

  [NSTimer scheduledTimerWithTimeInterval:0.1
                                   target:self
                                 selector:@selector(loading)
                                 userInfo:nil
                                  repeats:NO];
}

- (void)loading {
  if (curAngle > 90 - 360) {
    curAngle -= 10;

    [NSTimer scheduledTimerWithTimeInterval:0.1
                                     target:self
                                   selector:@selector(loading)
                                   userInfo:nil
                                    repeats:NO];
  } else {
    curAngle = 90;
    isLoading = NO;
  }

  loadingMaskLayer.path = [self pathOfSector:CGPointMake(90, 90) radius:60];
}

- (UIImage *)image:(UIImage *)image
           withCap:(int)location
          capWidth:(NSUInteger)capWidth
       buttonWidth:(NSUInteger)buttonWidth {
  UIGraphicsBeginImageContextWithOptions(
      CGSizeMake(buttonWidth, image.size.height), NO, 0.0);

  if (location == -1) {
    // Cap Left
    // To draw the left cap and not the right, we start at 0, and increase the
    // width of the image by the cap width to push the right cap out of view
    [image
        drawInRect:CGRectMake(0, 0, buttonWidth + capWidth, image.size.height)];
  } else if (location == 1) {
    // Cap Right
    // To draw the right cap and not the left, we start at negative the cap
    // width and increase the width of the image by the cap width to push the
    // left cap out of view
    [image drawInRect:CGRectMake(0.0 - capWidth, 0, buttonWidth + capWidth,
                                 image.size.height)];
  } else if (location == 0) {
    // Cap Center
    // To draw neither cap, we start at negative the cap width and increase the
    // width of the image by both cap widths to push out both caps out of view
    [image
        drawInRect:CGRectMake(0.0 - capWidth, 0, buttonWidth + (capWidth * 2),
                              image.size.height)];
  }

  UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return resultImage;
}

@end
