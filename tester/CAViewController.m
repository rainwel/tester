//
//  CAViewController.m
//  tester
//
//  Created by yiliao6 on 28/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "CAViewController.h"
#import "KCLayer.h"
#define WIDTH 60
#define PHOTO_HEIGHT 120

@implementation CAViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addMyLayer];
}

- (void)addMyLayer {
  /*CALayer *layer = [[CALayer alloc] init];
  layer.backgroundColor = [UIColor blueColor].CGColor;
  layer.position = CGPointMake(100, 100);
  layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
  layer.cornerRadius = WIDTH / 2;
  layer.shadowColor = [UIColor grayColor].CGColor;
  layer.shadowOffset = CGSizeMake(2, 2);
  layer.shadowOpacity = 1.0;

  [self.view.layer addSublayer:layer];*/

  CGRect bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
  CGPoint position = CGPointMake(80, 100);

  CALayer *layerShadow = [[CALayer alloc] init];
  layerShadow.bounds = bounds;
  layerShadow.position = position;
  layerShadow.cornerRadius = PHOTO_HEIGHT / 2;
  layerShadow.shadowColor = [UIColor grayColor].CGColor;
  layerShadow.shadowOffset = CGSizeMake(2, 1);
  layerShadow.shadowOpacity = 1;
  layerShadow.borderColor = [UIColor whiteColor].CGColor;
  layerShadow.borderWidth = 2;
  [self.view.layer addSublayer:layerShadow];

  //自定义图层
  CALayer *layer = [[CALayer alloc] init];

  layer.bounds = bounds;
  layer.position = position;
  layer.backgroundColor = [UIColor redColor].CGColor;
  layer.cornerRadius = PHOTO_HEIGHT / 2;
  //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
  //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
  layer.masksToBounds = YES;
  //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
  //而阴影效果刚好在外边框
  //    layer.shadowColor=[UIColor grayColor].CGColor;
  //    layer.shadowOffset=CGSizeMake(2, 2);
  //    layer.shadowOpacity=1;
  //设置边框
  layer.borderColor = [UIColor whiteColor].CGColor;
  layer.borderWidth = 2;
  layer.name = @"avatarLayer";
  //设置图层代理
  layer.delegate = self;

  UIImage *image = [UIImage imageNamed:@"avatar.png"];
  //    layer.contents=(id)image.CGImage;
  [layer setContents:(id)image.CGImage];

  //添加图层到根图层
  [self.view.layer addSublayer:layer];
  //调用图层setNeedDisplay,否则代理方法不会被调用
  //  [layer setNeedsDisplay];

  KCLayer *klayer = [[KCLayer alloc] init];
  klayer.bounds = CGRectMake(0, 0, 150, 150);
  klayer.position = CGPointMake(160, 400);
  klayer.backgroundColor =
      [UIColor colorWithRed:0 green:146 / 255.0 blue:1.0 alpha:1.0].CGColor;

  //显示图层
  [klayer setNeedsDisplay];

  //    layer.contents=(id)image.CGImage;
  //  [klayer setContents:(id)image.CGImage];

  [self.view.layer addSublayer:klayer];

  [self addWeixinLayer];
}

- (void)addWeixinLayer {
  //自定义图层
  CAShapeLayer *layer = [[CAShapeLayer alloc] init];

  //  layer.bounds = CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);

  //  layer.position = CGPointMake(100, 100);
  layer.backgroundColor = [UIColor redColor].CGColor;
  //  layer.cornerRadius = PHOTO_HEIGHT / 2;
  layer.path = [self pathFromSize:CGSizeMake(150, 150)];

  //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
  //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
  //  layer.masksToBounds = YES;
  //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
  //而阴影效果刚好在外边框
  //    layer.shadowColor=[UIColor grayColor].CGColor;
  //    layer.shadowOffset=CGSizeMake(2, 2);
  //    layer.shadowOpacity=1;
  //设置边框
  //设置图层代理
  //  layer.delegate = self;

  CAShapeLayer *backLayer = [[CAShapeLayer alloc] init];
  backLayer.backgroundColor =
      [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor;
  backLayer.path = [self pathFromSize:CGSizeMake(151, 151)];
  backLayer.position = CGPointMake(154.5, 29.5);
  backLayer.opacity = 0.1;
  //  backLayer.shadowColor = [UIColor grayColor].CGColor;
  //  backLayer.shadowOffset = CGSizeMake(-0.5, -0.5);
  //  backLayer.shadowOpacity = 0.5;
  [self.view.layer addSublayer:backLayer];

  CALayer *imgLayer = [[CALayer alloc] init];
  imgLayer.mask = layer;
  imgLayer.frame = CGRectMake(155, 30, 150, 150);
  imgLayer.shadowColor = [UIColor grayColor].CGColor;
  imgLayer.shadowOffset = CGSizeMake(2, 2);
  imgLayer.shadowOpacity = 1;
  imgLayer.borderColor = [UIColor blackColor].CGColor;
  imgLayer.borderWidth = 2;

  UIImage *image = [UIImage imageNamed:@"avatar.png"];
  //    layer.contents=(id)image.CGImage;
  [imgLayer setContents:(id)image.CGImage];
  //添加图层到根图层
  [self.view.layer addSublayer:imgLayer];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
  NSLog(@"layer.name -- %@", layer.name);  //这个图层正是上面定义的图层
                                           //  CGContextSaveGState(ctx);

  /*//图形上下文形变，解决图片倒立的问题
  CGContextScaleCTM(ctx, 1, -1);
  CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);

  UIImage *image = [UIImage imageNamed:@"avatar.png"];
  //注意这个位置是相对于图层而言的不是屏幕
  CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT),
                     image.CGImage);

  //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
  //    CGContextDrawPath(ctx, kCGPathFillStroke);

  CGContextRestoreGState(ctx);*/

  //  UIImage *image = [UIImage imageNamed:@"avatar.png"];
  //  //注意这个位置是相对于图层而言的不是屏幕
  //  CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT),
  //                     image.CGImage);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  /*UITouch *touch = [touches anyObject];
  CALayer *layer = self.view.layer.sublayers[0];
  CGFloat width = layer.bounds.size.width;

  width = (width == WIDTH ? WIDTH * 3 : WIDTH);
  layer.bounds = CGRectMake(0, 0, width, width);
  layer.cornerRadius = width / 2;
  layer.position = [touch locationInView:self.view];*/
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
@end
