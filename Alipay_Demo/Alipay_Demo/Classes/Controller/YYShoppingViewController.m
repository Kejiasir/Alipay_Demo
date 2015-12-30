//
//  YYShoppingViewController.m
//  Alipay_Demo
//
//  Created by Arvin on 15/12/14.
//  Copyright © 2015年 Arvin. All rights reserved.
//

#import "YYShoppingViewController.h"
#import "YYTableViewCell.h"
#import <MJExtension.h>
#import <MJRefreshNormalHeader.h>
/* Alipay */
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


@interface YYShoppingViewController ()
// 商品数组
@property (nonatomic, strong) NSArray *products;

@end

@implementation YYShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"团购";
    
    // tableView 行高
    self.tableView.rowHeight = 80;
    
    // MJ 刷新
    // 方式1 SEL回调（一旦进入刷新状态,就调用target的action,也就是调用self的loadNewData方法）
    //self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 方式2 block回调
    __weak typeof(self) weakVC = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [weakVC loadNewData];
    }];
    
    // 方式3 立即进入刷新
    //[self.tableView.mj_header beginRefreshing];
}

/**
 *   加载新数据
 */
- (void)loadNewData {
    // 模拟延时加载数据..
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 停止刷新
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
    });
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YYTableViewCell *cell = [YYTableViewCell tgsCell:tableView];
    YYProducts *product = self.products[indexPath.row];
    cell.product = product;
    return  cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 获取产品
    YYProducts *product = self.products[indexPath.row];
    YYLog(@"%@",product);
    
    /*
     * 商户的唯一的parnter和seller。
     * 签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    NSString *partner = @"xxx";
    NSString *seller = @"oooo";
    // 私钥,支付宝提供
    NSString *privateKey =
            @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOA795bV5FJ+4vmO"
            "xbqdBnLEBZQ7HrmkYJ8FZLMKY/a6PrwpON2ZDIkeLW5seObkLjsNWRMuEC5E0KJr"
            "L4EeFd/wC7cI93znGvg8ttIxSTHxzQCbjLFJKc+rzwE8CrLSBaCgfjXz09x3NGUJ"
            "XF2idPxOtLNIDAd85XcqcqmMOzhTAgMBAAECgYBEM1kJwoKQaNFmL/uJ18qnS2Gb"
            "BSRCOHG+zCgloIpo95qvJiaKl8tNRSVySYG4UDyTb2rhP4hiWkHOtKUdM2ZZRW29"
            "p1uEcDAUJ0+UeMtNXWyFy88iizuNrFOKlvdywVYm7GFEEB17VLhYi1W2X4IZTsfT"
            "9oNl2JJQFu8bowgRKQJBAO/RoS9i3do4Sli2MQkrcX5BaK/cGvbLxgWCqxjV8aPQ"
            "z6cbxxeT1ATtsv0h+cpQXAmxMrXC+0uk8Ec5kitH8U8CQQDvXSVPyRm7DlDCx+4r"
            "6GZZJDeUtHLLEJhwnJFjgrcgjiy7EVYlPi2I0d84hTecL47N+5gfA7qtmJ8ehEen"
            "Yp+9AkB8400uUS05ZBELi62TmeUbm9J5qoT8OvgfjIGviFKzPZ2155hRpfFGs8Z/"
            "Xj8n5ZtYjMfcsfKN3RIn9Uoycd+vAkEAm71eNoBhFn0k/Ob6x2TJmvxekYmrGwas"
            "OLEWQ8nb/vmijwCjrU28cMYk1/CNkzi6ULl/a8aQYrzn4wIsYPNhfQJBANIgs4Fr"
            "QArh4lGIy9bWxsummulu+Mv1hJhDnmejnWlb52TP4464M6OegPlziYRFS9hOyZ7i"
            "a6oIIV6vZNX3xFU=";
    
    /*
     * 生成订单信息及签名
     * 将商品信息赋予AlixPayOrder的成员变量
     */
    Order *order = [[Order alloc] init];         // 订单
    order.seller = seller;                       // 商户的唯一的seller
    order.partner = partner;                     // 商户的唯一的parnter
    order.amount = product.price;                // 商品价格
    order.tradeNO = product.orderId;             // 订单 ID
    order.productName = product.title;           // 商品标题
    order.productDescription = product.desc;     // 商品描述
    order.notifyURL =  @"http://www.xxx.com";    // 回调服务器的URL,异步返回支付结果
    
    order.showUrl = @"m.alipay.com";             // 显示支付结果的URL,固定值,不可空
    order.service = @"mobile.securitypay.pay";   // 客户端服务器接口名称,固定值,不可空
    order.paymentType = @"1";                    // 支付类型,默认值为:1(商品购买),不可空
    order.inputCharset = @"utf-8";               // 商户网站使用的编码格式,固定为utf-8,不可空
    order.itBPay = @"30m";                       // 未付款交易的超时时间,取值范围:1m~15d,可空
    
    
    // 应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"Alipay_Shopping";
    
    // 将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    YYLog(@"orderSpec = < %@ >",orderSpec);
    
    /**
     *  获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名
     *  只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
     */
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    // 将签名成功字符串格式化为订单字符串
    NSString *orderString = nil;
    if (signedString) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderSpec, signedString, @"RSA"];
        
        // 使用支付宝调起支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            YYLog(@"reslut = %@",resultDic);
        }];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - 懒加载
- (NSArray *)products {
    if (!_products) {
        // 通过plist来创建一个模型数组
        _products = [YYProducts mj_objectArrayWithFilename:@"tgs.plist"];
    }
    return _products;
}

- (void)dealloc {
    YYLog(@"%s",__func__);
}

@end
