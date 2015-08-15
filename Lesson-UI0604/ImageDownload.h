//
//  ImageDownload.h
//  Lesson-UI0604
//
//  Created by lin on 15/6/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 定义一个block把urlString转化得到的图片传回去 （block使用参数来传值）

typedef void(^result)(UIImage *img);

@interface ImageDownload : NSObject

#pragma -mark block不是对象 不需要加*
/*
 
 参数1 用来传递 请求的url
 参数2 用来传递 block返回的图片
 */
+ (void)imageDownloadWithUrlString:(NSString *)urlString andResult:(result)result;


@end
