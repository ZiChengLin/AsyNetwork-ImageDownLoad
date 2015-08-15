//
//  ImageDownload.m
//  Lesson-UI0604
//
//  Created by lin on 15/6/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ImageDownload.h"

@implementation ImageDownload

+(void)imageDownloadWithUrlString:(NSString *)urlString andResult:(result)result {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        // 将请求回来的data数据转化为图片UIImage类型并且传递出去
        UIImage *image = [UIImage imageWithData:data];
        // 通过block的形式将参数传递出去
        result(image);
        
    }];
}

@end
