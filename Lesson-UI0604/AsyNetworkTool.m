//
//  AsyNetworkTool.m
//  Lesson-UI0604
//
//  Created by lin on 15/6/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "AsyNetworkTool.h"
#import <UIKit/UIKit.h>

#pragma mark 延展 对于一下私有的属性或者方法，没必要在.h接口文件中公开 尽量写在延展中 有助于代码的封装和别人的使用
@interface AsyNetworkTool ()

@property (nonatomic, retain)NSMutableData *receiveData;  // 用来接收数据



@end

@implementation AsyNetworkTool

-(void)dealloc {
    
    [_dic release];
    [_receiveData release];
    [super dealloc];
}

-(id)initWithUrlString:(NSString *)urlString {
    
    self = [super init];
    if (self) {
        
        // 1.根据参数传递过来的url字符串创建一个url对象
        NSURL *url = [NSURL URLWithString:urlString];
        // 2.根据url对象封装request请求对象
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        // 3.发送请求并且设置代理
        [NSURLConnection connectionWithRequest:request delegate:self];
        
    }
    return self;
}

#pragma -mark 实现异步请求类的协议方法的实现
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"刚开始收到响应时执行的方法");
    // 初始化接收数据的data
    self.receiveData = [[NSMutableData alloc]init];
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSLog(@"正在接收数据时执行的方法");
    [self.receiveData appendData:data];    // 对于传过来的断断续续的数据拼接接收
        
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"接收完成时执行的方法");
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_receiveData options:NSJSONReadingMutableContainers error:nil];
    
    // 属性传值不行 （因为代码执行顺序不对）
    //self.dic = dic;
    //NSLog(@"self.dic = %@",self.dic);
    
    // 代理传值 (判断代理是否存在并且判断是否有实现相应代理方法)
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(asyResult:)]) {
        
        [self.delegate asyResult:dic];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    NSLog(@"接收出错时执行的方法");
}

@end
