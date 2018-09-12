//
//  LoginNetService.h
//  MACProject
//
//  Created by 唐斌 on 2018/9/13.
//  Copyright © 2018年 com.mackun. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  HTTP访问回调
 *
 *  @param urlString 状态码 0 访问失败   200 正常  500 空 其他异常
 *  @param result    返回数据 nil 为空
 *  @param error     错误描述
 */
typedef void(^ResultBlock)(NSInteger stateCode, NSMutableArray* result, NSError *error);
//block不是self的属性或者变量时，在block内使用self也不会循环引用
@interface LoginNetService : NSObject


/**
 *  普通的访问请求(有提示，带判断网络状态)
 *
 *  @param URLString    接口地址
 *  @param parameters   字典参数
 *  @param requestBlock 回调函数
 */
+ (void)POST:(NSString *)URLString  parameters:(id)parameters result:(ResultBlock)requestBlock;

@end
