//
//  SideBarViewController.m
//  tester
//
//  Created by yiliao6 on 7/11/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import "SideBarViewController.h"
#import <POP.h>

#define kMenuWidth 40
#define kMenuHeight 40
#define kMenuPadding 15
#define CGRectSetPos(r, x, y) CGRectMake(x, y, r.size.width, r.size.height)

@implementation SideBarViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  isShowMenu = NO;
  isPopAnimated = YES;
  btnList = [[NSMutableArray alloc] initWithCapacity:0];

  mainRect = [[UIScreen mainScreen] bounds];

  UIImageView *imgBack = [[UIImageView alloc]
      initWithImage:[UIImage imageNamed:@"background.png"]];
  imgBack.frame = CGRectMake(0, 0, mainRect.size.width, mainRect.size.height);
  imgBack.contentMode = UIViewContentModeScaleAspectFill;

  [self.view addSubview:imgBack];

  [self initMenus];
}

- (void)initMenus {

  menuBar =
      [[UIView alloc] initWithFrame:CGRectMake(mainRect.size.width, 0,
                                               kMenuWidth + kMenuPadding * 2,
                                               mainRect.size.height)];
  menuBar.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];

  [self.view addSubview:menuBar];
  NSArray *arrImages =
      @[ @"menuChat.png", @"menuMap.png", @"menuUsers.png", @"menuClose.png" ];

  float height = 40;
  for (int k = 0; k < arrImages.count; k++) {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:[arrImages objectAtIndex:k]]
         forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    //    [btn setImage:[UIImage imageNamed:[arrImages objectAtIndex:k]]
    //         forState:UIControlStateHighlighted];

    //    [btn setTintColor:[UIColor orangeColor]];
    btn.frame = CGRectMake(kMenuPadding, height, kMenuWidth, kMenuHeight);
    btn.tag = 1001 + k;
    [btn addTarget:self
                  action:@selector(onMenuClick:)
        forControlEvents:UIControlEventTouchUpInside];
    [menuBar addSubview:btn];
    [btnList addObject:btn];
    height += kMenuPadding + kMenuHeight;
  }

  btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
  [btnMenu setImage:[UIImage imageNamed:@"menuIcon.png"]
           forState:UIControlStateNormal];
  [btnMenu addTarget:self
                action:@selector(onMenuClick:)
      forControlEvents:UIControlEventTouchUpInside];
  btnMenu.adjustsImageWhenHighlighted = NO;
  btnMenu.tag = 1000;
  btnMenu.frame = CGRectMake(mainRect.size.width - kMenuWidth - kMenuPadding,
                             40, kMenuWidth, kMenuHeight);
  [self.view addSubview:btnMenu];
}

- (void)onMenuClick:(UIButton *)btn {
  switch (btn.tag) {
  case 1000:
    [self showMenu];
    break;

  default:
    [self hideMenu:btn];
    break;
  }
}

- (void)showMenu {
  if (isShowMenu) {
    return;
  }
  isShowMenu = YES;
  [self performSelectorInBackground:@selector(performShowMenu) withObject:nil];
}

- (void)hideMenu:(UIButton *)btn {

  if (isPopAnimated) {
    [btn pop_removeAllAnimations];
    POPSpringAnimation *sAnim =
        [POPSpringAnimation animationWithPropertyNamed:kPOPViewSize];
    sAnim.toValue = [NSValue
        valueWithCGSize:CGSizeMake(kMenuWidth * 1.2, kMenuHeight * 1.2)];
    sAnim.springBounciness = 16;
    sAnim.springSpeed = 20;

    [sAnim setCompletionBlock:^(POPAnimation *anim, BOOL isFinished) {
        isShowMenu = NO;
        [self performSelectorInBackground:@selector(performHideMenu)
                               withObject:nil];
    }];
    [btn pop_addAnimation:sAnim forKey:@"scale"];

  } else {
    [UIView animateWithDuration:0.3
        delay:0.0
        usingSpringWithDamping:0.3
        initialSpringVelocity:10.0
        options:0
        animations:^{
            btn.transform =
                CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        }
        completion:^(BOOL finished) {
            isShowMenu = NO;
            [self performSelectorInBackground:@selector(performHideMenu)
                                   withObject:nil];
        }];
  }
}

- (void)performShowMenu {

  if (isPopAnimated) {

    float duration = 0.3;

    POPBasicAnimation *pAnim =
        [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    pAnim.fromValue = @(1.0);
    pAnim.toValue = @(0.0);
    pAnim.duration = duration;
    pAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [btnMenu pop_addAnimation:pAnim forKey:@"fadeout"];

    POPBasicAnimation *tAnim =
        [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    tAnim.toValue = [NSValue
        valueWithCGPoint:CGPointMake(mainRect.size.width - kMenuWidth * 1.5 -
                                         kMenuPadding * 3,
                                     40 + kMenuHeight / 2)];
    tAnim.duration = duration;
    tAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [btnMenu pop_addAnimation:tAnim forKey:@"translate"];

    POPBasicAnimation *sAnim =
        [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    sAnim.toValue =
        [NSValue valueWithCGPoint:CGPointMake(mainRect.size.width -
                                                  kMenuWidth / 2 - kMenuPadding,
                                              mainRect.size.height / 2)];
    sAnim.duration = duration;
    sAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [menuBar pop_addAnimation:sAnim forKey:@"hide"];
    float height = 40;
    for (int k = 0; k < btnList.count; k++) {
      UIButton *btn = (UIButton *)[btnList objectAtIndex:k];
      btn.frame =
          CGRectMake(kMenuPadding + 26, height, kMenuWidth, kMenuHeight);

      POPSpringAnimation *sAnim =
          [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
      sAnim.toValue =
          [NSValue valueWithCGPoint:CGPointMake(kMenuPadding + kMenuWidth / 2,
                                                height + kMenuHeight / 2)];
      sAnim.springBounciness = 12;
      sAnim.springSpeed = 8;
      sAnim.beginTime = CACurrentMediaTime() + 0.08 * k;
      [btn pop_addAnimation:sAnim forKey:@"translate"];

      height += kMenuPadding + kMenuHeight;
    }

  } else {
    [UIView animateWithDuration:0.3
                     animations:^{
                         btnMenu.alpha = 0.0f;
                         btnMenu.transform = CGAffineTransformTranslate(
                             CGAffineTransformIdentity,
                             -kMenuWidth - kMenuPadding * 2, 0);
                         menuBar.transform = CGAffineTransformTranslate(
                             CGAffineTransformIdentity,
                             -kMenuWidth - kMenuPadding * 2, 0);
                     }];
    int k = 0;
    for (UIButton *btn in btnList) {
      dispatch_async(dispatch_get_main_queue(), ^{
          btn.transform =
              CGAffineTransformTranslate(CGAffineTransformIdentity, 26, 0);
          [UIView animateWithDuration:0.3
              delay:k * 0.1 + 0.2f
              usingSpringWithDamping:0.4
              initialSpringVelocity:10.f
              options:0
              animations:^{

                  btn.transform = CGAffineTransformTranslate(
                      CGAffineTransformIdentity, 0, 0);
              }
              completion:^(BOOL finished){

              }];

      });
      k++;
    }
  }
}

- (void)performHideMenu {
  if (isPopAnimated) {
    float duration = 0.3;

    POPBasicAnimation *pAnim =
        [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    pAnim.fromValue = @(0.0);
    pAnim.toValue = @(1.0);
    pAnim.duration = duration;
    pAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [btnMenu pop_addAnimation:pAnim forKey:@"fadeout"];

    POPBasicAnimation *tAnim =
        [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    tAnim.toValue =
        [NSValue valueWithCGPoint:CGPointMake(mainRect.size.width -
                                                  kMenuWidth / 2 - kMenuPadding,
                                              40 + kMenuHeight / 2)];
    tAnim.duration = duration;
    tAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [btnMenu pop_addAnimation:tAnim forKey:@"translate"];

    POPBasicAnimation *sAnim =
        [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    sAnim.toValue =
        [NSValue valueWithCGPoint:CGPointMake(mainRect.size.width +
                                                  kMenuWidth / 2 + kMenuPadding,
                                              mainRect.size.height / 2)];
    sAnim.duration = duration;
    sAnim.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [menuBar pop_addAnimation:sAnim forKey:@"hide"];

  } else {
    [UIView animateWithDuration:0.3
                     animations:^{
                         btnMenu.alpha = 1.0f;
                         btnMenu.transform = CGAffineTransformTranslate(
                             CGAffineTransformIdentity, 0, 0);
                         menuBar.transform = CGAffineTransformTranslate(
                             CGAffineTransformIdentity, 0, 0);
                     }];
  }
}

@end
