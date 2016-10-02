//
//  BannerView.h
//  BannerView
//
//  Created by Scorpio on 16/6/3.
//  Copyright © 2016年 Scorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)UIImageView *leftImageView;
@property (strong, nonatomic)UIImageView *centerImageView;
@property (strong, nonatomic)UIImageView *rightImageView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property ( nonatomic)int currentImageIndex;//当前图片索引
@property ( nonatomic)int imgCount;//当前图片索引

@property (weak, nonatomic) IBOutlet UILabel *labMessage;

@property (strong ,nonatomic)NSArray *arrImg;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) void (^BannerBlock)(NSInteger index); //选中的图片顺位


-(void)setImageContents:(NSArray*)arrImg;  //初始化图片的数组，uimiage对像的数组

@end
