//
//  ViewController.h
//  SlidePageIntro
//
//  Created by Will Chilcutt on 7/30/13.
//  Copyright (c) 2013 ERCLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *backgroundScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *foregroundScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end
