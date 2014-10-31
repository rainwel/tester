//
//  KCLayer.m
//  tester
//
//  Created by yiliao6 on 29/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "KCLayer.h"

@implementation KCLayer

- (void)drawInContext:(CGContextRef)ctx {
  NSLog(@"3-drawInContext:");
  NSLog(@"CGContext:%@", ctx);
  //    CGContextRotateCTM(ctx, M_PI_4);
  CGContextSetRGBFillColor(ctx, 100.0 / 255.0, 100.0 / 255.0, 100.0 / 255.0, 1);
  CGContextSetRGBStrokeColor(ctx, 200.0 / 255.0, 200.0 / 255.0, 200.0 / 255.0,
                             1);
  //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
  //    CGContextFillEllipseInRect(ctx, CGRectMake(50, 50, 100, 100));
  CGContextMoveToPoint(ctx, 94.5, 33.5);

  //// Star Drawing
  CGContextAddLineToPoint(ctx, 104.02, 47.39);
  CGContextAddLineToPoint(ctx, 130.18, 52.16);
  CGContextAddLineToPoint(ctx, 109.91, 65.51);
  CGContextAddLineToPoint(ctx, 110.37, 82.34);
  CGContextAddLineToPoint(ctx, 94.5, 76.7);
  CGContextAddLineToPoint(ctx, 78.63, 82.34);
  CGContextAddLineToPoint(ctx, 79.09, 65.51);
  CGContextAddLineToPoint(ctx, 68.82, 52.16);
  CGContextAddLineToPoint(ctx, 84.98, 47.39);
  CGContextClosePath(ctx);

  CGContextDrawPath(ctx, kCGPathFillStroke);

  CGDataProviderRef dataProvider =
      CGDataProviderCreateWithFilename("avatar.png");
  CGImageRef image = CGImageCreateWithPNGDataProvider(
      dataProvider, NULL, NO, kCGRenderingIntentDefault);
  CGContextDrawImage(ctx, CGRectMake(0, 0, 120, 120), image);
    
    
  //  UIImage *image = [UIImage imageNamed:@"avatar.png"];
  //    layer.contents=(id)image.CGImage;
  //  [layer setContents:(id)image.CGImage];
}

@end
