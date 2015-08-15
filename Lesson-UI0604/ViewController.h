//
//  ViewController.h
//  Lesson-UI0604
//
//  Created by lin on 15/6/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end


/*
    
   异步下载图片 cell逐行显示图片
   使用观察者模式 kvo观察pic_url_image是否被请求回来，再进行逐行显示
 
 */