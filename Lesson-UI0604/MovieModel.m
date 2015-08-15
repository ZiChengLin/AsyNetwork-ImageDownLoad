//
//  MovieModel.m
//  Lesson-UI0604
//
//  Created by lin on 15/6/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "MovieModel.h"
#import "ImageDownload.h"

@implementation MovieModel

-(void)dealloc {
    
    [_movieId release];
    [_movieName release];
    [_pic_url release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    NSLog(@"crush");
}

// 重写其setter方法的目的 (在setValuesForKeysWithDictionary的时候调用该方法)
-(void)setPic_url:(NSString *)pic_url {
    
    if (_pic_url == pic_url) {
        [_pic_url release];
        _pic_url = [pic_url retain];
    }
    
    
    __block MovieModel *model = self;
    [ImageDownload imageDownloadWithUrlString:pic_url andResult:^(UIImage *img) {
        
        model.pic_url_image = img;
        
    }];
}

@end
