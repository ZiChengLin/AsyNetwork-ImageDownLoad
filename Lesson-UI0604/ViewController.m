//
//  ViewController.m
//  Lesson-UI0604
//
//  Created by lin on 15/6/4.
//  Copyright (c) 2015年 lin. All rights reserved.
//

#import "ViewController.h"
#import "AsyNetworkTool.h"
#import "MovieModel.h"

#define BaseUrl @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php"

@interface ViewController ()<AsyNetworkToolDelegate>   // 1.遵守代理

@property (nonatomic, retain)NSMutableArray *modelArray;

@property (nonatomic, retain)UIActivityIndicatorView *act;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AsyNetworkTool *asy = [[AsyNetworkTool alloc]initWithUrlString:BaseUrl];
    asy.delegate = self;   // 2. 指定代理人
    
    //NSLog(@"asy.dic = %@", asy.dic);   // 属性传值传不过来
    
    
    // 初始化modelArray对象数组（在这里初始化比较好）
    self.modelArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    // 添加活动指示器 (还没有请求回来数据的时候)
    self.act = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _act.center = self.tableView.center;
    // 设置风格
    _act.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    // 设置活动指示器的颜色
    _act.color = [UIColor orangeColor];
    // hidesWhenStopped默认为YES 会掩藏活动指示器 要改为NO
    _act.hidesWhenStopped = NO;
    // 启动
    [_act startAnimating];
    [self.tableView addSubview:_act];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 3.实现代理方法 把数据传过来
-(void)asyResult:(id)result {
    
    NSDictionary *dic = (NSDictionary *)result;
    //NSLog(@"%@", dic);
    
    NSArray *resultArray = [dic valueForKey:@"result"];
    //NSLog(@"%@", resultArray);
    for (NSDictionary *rDic in resultArray) {
        
        MovieModel *movieModel = [[MovieModel alloc]init];
        [movieModel setValuesForKeysWithDictionary:rDic];
        
        [_modelArray addObject:movieModel];
        
#pragma -mark 拿到数据之后一定窑刷新一下表视图 (reloadData的实质是强制让协议方法重新走一遍)
        [self.tableView reloadData];
        
        [movieModel release];
        
        // 停止活动指示器 （请求数据结束）
        [self.act stopAnimating];
        _act.hidesWhenStopped = YES;
    }
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_modelArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // 将model类从数组里面取出来
    MovieModel *movieModel = [self.modelArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = movieModel.movieName;
    cell.detailTextLabel.text = movieModel.movieId;
    //cell.imageView.image = movieModel.pic_url_image;    // 不可取
    
    // 如果pic_url_image存在即已经请求回来了 则直接使用
    if (movieModel.pic_url_image != nil) {
        
        cell.imageView.image = movieModel.pic_url_image;
        
    } else {
        
        // 使用kvo观察pic_url_image是否被请求回来
        [movieModel addObserver:self forKeyPath:@"pic_url_image" options:NSKeyValueObservingOptionNew context:(__bridge void*)(indexPath)];
    }
    
    return cell;
}

// 该方法是观察者发现被观察者的被观察的哪一个属性发生改变时就自动调用的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"pic_url_image"]) {
        
        // 1.先取出请求回来的图片
        UIImage *newImage = change[NSKeyValueChangeNewKey];
        // 2.取出cell
        NSIndexPath *indexPath = (__bridge NSIndexPath*)context;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        // 3.往cell上面添加图片
        cell.imageView.image = newImage;
        
        // 4.刷新cell
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // 5.移除观察者
        [object removeObserver:self forKeyPath:@"pic_url_image"];
    }
    
}

- (void)dealloc {
    [_tableView release];
    [_modelArray release];
    [_act release];
    [super dealloc];
}
@end
