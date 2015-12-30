//
//  ViewController.m
//  Alipay_Demo
//
//  Created by Arvin on 15/12/14.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import "YYShoppingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"吃货商城";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake((YYUIScreenWidth-YYButtonWidth)*0.5, 106, YYButtonWidth, YYButtonHeight)];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"去逛逛" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderWidth = 1.5;
    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
    
}

- (void)buttonClick {
    YYLog(@"%s",__func__);
    YYShoppingViewController *shoppingVC = [[YYShoppingViewController alloc] init];
    [self.navigationController pushViewController: shoppingVC animated:YES];
}
@end
