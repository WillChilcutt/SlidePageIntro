//
//  ViewController.m
//  SlidePageIntro
//
//  Created by Will Chilcutt on 7/30/13.
//  Copyright (c) 2013 ERCLab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUpBackgroundScrollViewPages];
    [self moveBackgroundScrollViewToLastPage];
    [self setUpForegroundScrollViewPages];
}

#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if (sender == self.foregroundScrollView)
    {
        [self moveBackgroundScrollViewInOppositeDirection];
        [self updatePageControlForScrollView:sender];
    }
}

#pragma mark Custom methods

-(void)setUpBackgroundScrollViewPages
{
    NSArray *backgroundColors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    for (int i = 0; i < backgroundColors.count; i++)
    {
        CGRect frame;
        frame.origin.x = self.backgroundScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.backgroundScrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [backgroundColors objectAtIndex:i];
        [self.backgroundScrollView addSubview:subview];
    }
    
    self.backgroundScrollView.contentSize = CGSizeMake(self.backgroundScrollView.frame.size.width * backgroundColors.count, self.backgroundScrollView.frame.size.height);
}

-(void)setUpForegroundScrollViewPages
{
    for (int i = 0; i < 3; i++)
    {
        CGRect frame;
        frame.origin.x = self.foregroundScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.foregroundScrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [UIColor clearColor];
        subview.alpha = 1;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.foregroundScrollView.frame.size.width, self.foregroundScrollView.center.y)];
        [label setTextColor:[UIColor blackColor]];
        [label setText:[NSString stringWithFormat:@"Page %d",i]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [subview addSubview:label];
        [self.foregroundScrollView addSubview:subview];
    }
    
    self.foregroundScrollView.contentSize = CGSizeMake(self.foregroundScrollView.frame.size.width * 3, self.foregroundScrollView.frame.size.height);
}

-(void)moveBackgroundScrollViewToLastPage
{
    CGRect frame = self.backgroundScrollView.frame;
    int numberOfPages = self.backgroundScrollView.contentSize.width/self.backgroundScrollView.frame.size.width;
    frame.origin.x = frame.size.width * (numberOfPages-1);
    frame.origin.y = 0;
    [self.backgroundScrollView scrollRectToVisible:frame animated:NO];
}

-(void)moveBackgroundScrollViewInOppositeDirection
{
    float oppositeX = self.backgroundScrollView.contentSize.width - self.backgroundScrollView.frame.size.width - self.foregroundScrollView.contentOffset.x;
    self.backgroundScrollView.contentOffset = CGPointMake(oppositeX, 0);
}

-(void)updatePageControlForScrollView:(UIScrollView *)scrollView
{
    // Update the page when more than 50% of the previous/next page is visibles
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}
@end
