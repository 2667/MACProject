//
//  LoginNetService.m
//  MACProject
//
//  Created by 唐斌 on 2018/9/13.
//  Copyright © 2018年 com.mackun. All rights reserved.
//

#import "LoginNetService.h"
#import "HttpClient.h"
#import "EGOCache.h"
#import "BaseModel.h"
#import "NSObjcet+MAC.h"
#import "NSDictionary+MAC.h"
#import "TSMessage.h"
#define REQUEST_ERROR(aCode)    (aCode==-1009?@"亲，咋没连接网络呢~~~":@"亲，服务器在偷懒哦~~~")
#define DATA_ERROR     @"亲，服务器正在打瞌睡哦，稍后重试吧"


/**
 *  接口回调
 *
 *  @param result    返回数据
 *  @param errorCode 错误码
 *  @param messgae   错误代码
 */
typedef void(^ServerBlock)(id result, NSInteger errorCode, NSString *message);

@implementation LoginNetService

+(void)POST:(NSString *)URLString  parameters:( id)parameters result:(ResultBlock)requestBlock{
    if ([HTTPClient sharedHTTPClient].isReachable) {//有网络
        
        NSURL* url_address = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

        [[HTTPClient sharedHTTPClient] POST:url_address.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (requestBlock) {
                //     NSDictionary *dic=(NSDictionary *)responseObject;
                BaseModel *baseModel=[BaseModel mj_objectWithKeyValues:responseObject];
                requestBlock(baseModel.State,[baseModel.Result jsonBase64Value],nil);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self showMessage:[error code]];
            if (requestBlock) {
                requestBlock(0,nil,error);
            }
        }];
    }
    else
    {
        [self showMessage:0];
        if (requestBlock) {
            requestBlock(0,nil,nil);
        }
        
    }
}


/**
 *  展示网络状态信息
 */
+(void)showMessage:(NSInteger)code
{
    NSString *subTitle=@"尝试连接网络,并重试";
    if (code !=-1009) {
        subTitle=@"您的服务器被程序猿搬走了,稍后重试吧";
    }
    [TSMessage showNotificationInViewController:[UIApplication sharedApplication].getCurrentViewConttoller
                                          title:REQUEST_ERROR(code)
                                       subtitle:subTitle
                                           type:TSMessageNotificationTypeWarning];
}

@end
