//
//  BannerView.m
//  BannerView
//
//  Created by Scorpio on 16/6/3.
//  Copyright © 2016年 Scorp. All rights reserved.
//

#import "BannerView.h"

@implementation BannerView


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit
{
    _customConstraints = [[NSMutableArray alloc] init];
    
    UIView *view = nil;
    NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"BannerView"
                                                     owner:self
                                            options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:[UIView class]]) {
            view = object;
            break;
        }
    }
    
    if (view != nil) {
        _containerView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self setNeedsUpdateConstraints];
    }
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    [self removeConstraints:self.customConstraints];
    [self.customConstraints removeAllObjects];
    
    if (self.containerView != nil) {
        UIView *view = self.containerView;
        NSDictionary *views = NSDictionaryOfVariableBindings(view);
        [self.customConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:
          @"H:|[view]|" options:0 metrics:nil views:views]];
        [self.customConstraints addObjectsFromArray:
         [NSLayoutConstraint constraintsWithVisualFormat:
          @"V:|[view]|" options:0 metrics:nil views:views]];
        [self addConstraints:self.customConstraints];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tap];
    [self addTimer];
    
}



-(void)viewTapped:(UITapGestureRecognizer*)tap{
    __weak __typeof__(self) weakSelf = self;
    NSInteger index = weakSelf.pageControl.currentPage;
    if (self.BannerBlock) {
        weakSelf.BannerBlock(index);
    }
}

-(void)setImageContents:(NSArray*)arrImg{
    _arrImg = arrImg;
    _imgCount = (int)_arrImg.count;
    [self initImageView];
    [self setDefaultImg];
    self.pageControl.numberOfPages =  _imgCount;
}

-(void)initImageView{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    _leftImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_leftImageView];
    _centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(width, 0, width,height)];
    _centerImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_centerImageView];
    _rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(2*width, 0, width, height)];
    _rightImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_rightImageView];
    self.scrollView.contentSize = CGSizeMake(3 * width, 0);
    [_scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    self.scrollView.delegate = self;
}

-(void)setDefaultImg{
//    [_leftImageView loadGoodsImageWithPath:_arrImg.lastObject];
//    [_centerImageView loadGoodsImageWithPath:_arrImg[0]];
//    [_rightImageView loadGoodsImageWithPath: _arrImg[(_imgCount + 1)%_imgCount]];
    [_leftImageView sd_setImageWithURL:_arrImg.lastObject placeholderImage:nil];
    [_centerImageView sd_setImageWithURL:_arrImg[0] placeholderImage:nil];
    [_rightImageView sd_setImageWithURL: _arrImg[(_imgCount + 1)%_imgCount] placeholderImage:nil];
    _currentImageIndex = 0;
    _pageControl.currentPage = _currentImageIndex;
}

-(void)reloadImg{

    CGFloat width = self.frame.size.width;
    int leftImageIndex,rightImageIndex;
    CGPoint offset=[_scrollView contentOffset];
    if (offset.x >= width) { // 向右滑动
        _currentImageIndex=(_currentImageIndex+1)% _imgCount;
    }else if(offset.x < width){
        _currentImageIndex=(_currentImageIndex+_imgCount-1)%_imgCount;
    }
    leftImageIndex=(_currentImageIndex+_imgCount-1)%_imgCount;
    rightImageIndex=(_currentImageIndex+1)%_imgCount;
    
//    [_leftImageView loadGoodsImageWithPath:_arrImg[leftImageIndex]];
//    [_rightImageView loadGoodsImageWithPath:_arrImg[rightImageIndex]];
//    [_centerImageView loadGoodsImageWithPath:_arrImg[_currentImageIndex]];
    [_leftImageView sd_setImageWithURL:_arrImg[leftImageIndex] placeholderImage:nil];
    [_rightImageView sd_setImageWithURL:_arrImg[rightImageIndex] placeholderImage:nil];
    [_centerImageView sd_setImageWithURL:_arrImg[_currentImageIndex] placeholderImage:nil];

    _pageControl.currentPage=_currentImageIndex;
    
}

-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(beginAnimation) userInfo:nil repeats:YES];
}

-(void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)beginAnimation{
    CGFloat x = 2 *self.scrollView.frame.size.width;
    [self.scrollView setContentOffset: CGPointMake(x, 0) animated:YES];

}

-(void)nextImg{
    _currentImageIndex = (_currentImageIndex+1)% _imgCount;
    int leftImageIndex,rightImageIndex;
    leftImageIndex=(_currentImageIndex+_imgCount-1)%_imgCount;
    rightImageIndex=(_currentImageIndex+1)%_imgCount;
    
//    [_leftImageView loadGoodsImageWithPath:_arrImg[leftImageIndex]];
//    [_rightImageView loadGoodsImageWithPath:_arrImg[rightImageIndex]];
//    [_centerImageView loadGoodsImageWithPath:_arrImg[_currentImageIndex]];
    
    [_leftImageView sd_setImageWithURL:_arrImg[leftImageIndex] placeholderImage:nil];
    [_rightImageView sd_setImageWithURL:_arrImg[rightImageIndex] placeholderImage:nil];
    [_centerImageView sd_setImageWithURL:_arrImg[_currentImageIndex] placeholderImage:nil];

    
    _pageControl.currentPage=_currentImageIndex;
}

#pragma mark --ScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImg];
    CGFloat width = scrollView.frame.size.width;
    [_scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
//
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self nextImg];
    CGFloat width = scrollView.frame.size.width;
    [_scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
}


@end
