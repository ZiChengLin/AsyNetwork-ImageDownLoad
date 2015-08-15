//
//  MovieModel.h
//  Lesson-UI0604
//
//  Created by lin on 15/6/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieModel : NSObject

#pragma -mark 数据模型 很多重复的数据
@property (nonatomic, retain)NSString *movieId;
@property (nonatomic, retain)NSString *movieName;

// 该属性是需要做二次请求的属性 其他类不能直接使用该属性
@property (nonatomic, retain)NSString *pic_url;
// 该属性是通过pic_url请求回来的最终数据 需要给其他类直接使用的
@property (nonatomic, retain)UIImage *pic_url_image;   // 可读性高

@end
