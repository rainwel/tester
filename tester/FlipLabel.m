//
//  FlipLabel.m
//  tester
//
//  Created by yiliao6 on 28/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "FlipLabel.h"

@implementation FlipLabel

- (void)setTransFactor:(float)val {
  transFactor = val;
  CATransform3D aTransform = CATransform3DIdentity;
  aTransform.m34 = 1.0 / -400;
  self.layer.transform = CATransform3DRotate(aTransform, val, 1, 0, 0);
  NSLog(@"transFactor - %f", val);
}

- (float)getTransFactor {
  return transFactor;
}
@end
