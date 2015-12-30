//
//  AlixPayResult.h
//  MSPInterface
//
//  Created by WenBi on 11-5-20.
//  Copyright 2011 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlixPayResult : NSObject {
    /**
     *  状态码
     *  8000  正在处理中
     *  9000  订单支付成功
     *  4000  订单支付失败
     *  6001  用户中途取消
     *  6002  网络连接出错
     */
    int	_statusCode;
    
    /**
     *  提示信息, 但千万别完全依赖这个信息
     *  比如状态码为6001时, _statusMessage就是“用户中途取消”。
     *  如果未安装支付宝app, 采用wap支付时，取消时状态码是6001, 但这个memo是空的
     */
    NSString *_statusMessage;
    
    /**
     *  订单信息以及验证签名信息
     */
    NSString *_resultString;
    
    /**
     *  如果不想做签名验证, 那这个字段可以忽略
     */
    NSString *_signString;
    
    /**
     *  签名类型
     */
    NSString *_signType;
}

@property(nonatomic, readonly) int statusCode;
@property(nonatomic, readonly) NSString *statusMessage;
@property(nonatomic, readonly) NSString *resultString;
@property(nonatomic, readonly) NSString *signString;
@property(nonatomic, readonly) NSString *signType;

- (id)initWithString:(NSString *)string;

@end



