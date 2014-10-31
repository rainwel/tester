//
//  HomeViewController.h
//  tester
//
//  Created by yiliao6 on 22/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlipLabel.h"
#import <POP.h>

@interface HomeViewController : UIViewController {
  UIView *testView;
  UIView *rotateView;
  UILabel *lblTitle;

  UIButton *btn;
  FlipLabel *lblFlip;

  BOOL animatingOut;
}
@end
