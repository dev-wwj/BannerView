//
//  ViewController.m
//  Sc_BannerView
//
//  Created by 王文建 on 2016/11/30.
//  Copyright © 2016年 Scorp. All rights reserved.
//

#import "ViewController.h"

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
    NSArray *imgUrlArr = @[@"http://f.hiphotos.baidu.com/image/h%3D200/sign=c253602d791ed21b66c929e59d6cddae/b151f8198618367a9f738e022a738bd4b21ce573.jpg",@"http://f.hiphotos.baidu.com/image/h%3D200/sign=a2c37cfc0846f21fd6345953c6246b31/00e93901213fb80e0ee553d034d12f2eb9389484.jpg",@"http://g.hiphotos.baidu.com/image/h%3D200/sign=f89cc11abb389b5027ffe752b535e5f1/c8177f3e6709c93dbe82d5f39d3df8dcd1005446.jpg"];
    [_bannerView setImageContents:imgUrlArr];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
