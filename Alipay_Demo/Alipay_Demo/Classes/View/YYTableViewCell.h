//
//  YYTableViewCell.h
//  Alipay_Demo
//
//  Created by Arvin on 15/12/14.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYProducts.h"

@interface YYTableViewCell : UITableViewCell

@property (nonatomic, strong) YYProducts *product;

+ (instancetype)tgsCell:(UITableView *)tableView;

@end
