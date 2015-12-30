//
//  YYTableViewCell.m
//  Alipay_Demo
//
//  Created by Arvin on 15/12/14.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import "YYTableViewCell.h"

@interface YYTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;

@end

@implementation YYTableViewCell

+ (instancetype)tgsCell:(UITableView *)tableView {
    static NSString *identifier = @"TgsCell";
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYTableViewCell" owner:self options:nil] lastObject];
    }
    return cell;
}

- (void)setProduct:(YYProducts *)product {
    _product = product;
    self.iconView.image = [UIImage imageNamed: product.icon];
    self.titleLabel.text = product.title;
    self.descLabel.text = product.desc;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ 元",product.price];
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@ 人已购买",product.buyCount];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
