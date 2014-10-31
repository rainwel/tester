//
//  FlipLabel.h
//  tester
//
//  Created by yiliao6 on 28/10/14.
//  Copyright (c) 2014 yiliao6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipLabel : UILabel {
  float transFactor;
}

- (void)setTransFactor:(float)val;
- (float)getTransFactor;
@end
