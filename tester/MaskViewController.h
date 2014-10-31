//
//  MaskViewController.h
//  tester
//
//  Created by yiliao6 on 30/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaskViewController : UIViewController {
  float curAngle;
  UIImageView *imgLoading;
  BOOL isLoading;

  CAShapeLayer *loadingMaskLayer;
}
@end
