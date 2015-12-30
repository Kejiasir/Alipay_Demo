//
//  YYProducts.h
//  Alipay_Demo
//
//  Created by Arvin on 15/12/15.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYProducts : NSObject
@property (nonatomic, strong) NSString *title;    /// 标题
@property (nonatomic, strong) NSString *icon;     /// 图片
@property (nonatomic, strong) NSString *desc;     /// 描述
@property (nonatomic, strong) NSString *price;    /// 价格
@property (nonatomic, strong) NSString *orderId;  /// 订单 ID
@property (nonatomic, strong) NSString *buyCount; /// 购买人数
@end
