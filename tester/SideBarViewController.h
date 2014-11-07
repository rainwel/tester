//
//  SideBarViewController.h
//  tester
//
//  Created by yiliao6 on 7/11/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBarViewController : UIViewController {
  UIButton *btnMenu;
  UIView *menuBar;
  CGRect mainRect;
  BOOL isShowMenu;
  BOOL isPopAnimated;
  NSMutableArray *btnList;
}
@end
