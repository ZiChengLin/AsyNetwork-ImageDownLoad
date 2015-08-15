//
//  AsyNetworkTool.h
//  Lesson-UI0604
//
//  Created by lin on 15/6/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AsyNetworkToolDelegate <NSObject>

// 虽然我们传递的是字典，但是还可以是其他对象 所以用id比较好
- (void)asyResult:(id)result;

@end

@interface AsyNetworkTool : NSObject<NSURLConnectionDataDelegate>

// 返回类型是id类型 因为不知道要返回的具体类型
#pragma -mark 根据一个url创建一个异步请求对象
- (id)initWithUrlString:(NSString *)urlString;

// 用来存放请求回来的数据的属性
@property (nonatomic, retain)NSDictionary *dic;

@property (nonatomic, assign)id<AsyNetworkToolDelegate>delegate;     // 声明代理属性

@end
