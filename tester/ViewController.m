//
//  ViewController.m
//  CustomScrollView
//
//  Created by Ole Begemann on 16.04.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "ViewController.h"
#import "CustomScrollView.h"

@interface ViewController ()

@property(nonatomic) CustomScrollView *customScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.customScrollView =
      [[CustomScrollView alloc] initWithFrame:self.view.bounds];
  self.customScrollView.contentSize =
      CGSizeMake(self.view.bounds.size.width, 5000);
  int offsetY = 0;
  for (int k = 0; k < 60; k++) {
    int newHeight = arc4random() % 60 + 40;
    UIView *vitem =
        [[UIView alloc] initWithFrame:CGRectMake(0, offsetY, 300, newHeight)];
    offsetY += newHeight + 2;
    switch (k % 4) {
    case 0:
      vitem.backgroundColor = [UIColor redColor];
      break;
    case 1:
      vitem.backgroundColor = [UIColor greenColor];
      break;
    case 2:
      vitem.backgroundColor = [UIColor blueColor];
      break;
    default:
      vitem.backgroundColor = [UIColor yellowColor];
      break;
    }
    [self.customScrollView addSubview:vitem];
  }

  /*UIView *redView1 =
      [[UIView alloc] initWithFrame:CGRectMake(20, 500 + 20, 100, 100)];
  UIView *greenView1 =
      [[UIView alloc] initWithFrame:CGRectMake(150, 500 + 160, 150, 200)];
  UIView *blueView1 =
      [[UIView alloc] initWithFrame:CGRectMake(40, 500 + 400, 200, 150)];
  UIView *yellowView1 =
      [[UIView alloc] initWithFrame:CGRectMake(100, 500 + 600, 180, 150)];

  redView1.backgroundColor = [UIColor purpleColor];
  greenView1.backgroundColor = [UIColor redColor];
  blueView1.backgroundColor = [UIColor grayColor];
  yellowView1.backgroundColor = [UIColor blackColor];

  [self.customScrollView addSubview:redView1];
  [self.customScrollView addSubview:greenView1];
  [self.customScrollView addSubview:blueView1];
  [self.customScrollView addSubview:yellowView1];*/

  [self.view addSubview:self.customScrollView];
}

@end
