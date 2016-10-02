//
//  ViewController.m
//  BannerViewDemo
//
//  Created by 王文建 on 16/10/2.
//  Copyright © 2016年 Scorp. All rights reserved.
//

#import "ViewController.h"
#import "BannerView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet BannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_bannerView setImageContents:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
