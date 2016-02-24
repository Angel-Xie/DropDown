//
//  ViewController.m
//  下拉放大
//
//  Created by 谢小御 on 15/12/26.
//  Copyright © 2015年 谢小御. All rights reserved.
//
#define kImageH 150
#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
//赋值数组
@property (nonatomic,strong) NSMutableArray *myDataArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIImageView *imageView;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myDataArray = [NSMutableArray arrayWithObjects:@"御坂美琴",@"夏娜",@"Saber",@"希尔瓦娜斯",@"阿尔托莉雅", nil];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor orangeColor];
    //设置tableView被包围的范围,设置距离上边  #define kImageH 150  距离
    self.tableView.contentInset = UIEdgeInsetsMake(kImageH, 0, 0, 0);
    [self.view addSubview:self.tableView];
    //设置imageView的图片
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"11"]];
    //设置初始大小,
    self.imageView.frame = CGRectMake(0, -kImageH, self.tableView.frame.size.width, kImageH);
    [self.tableView addSubview:self.imageView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cell_id = @"sure";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
        cell.textLabel.text = self.myDataArray[indexPath.row];
    }
    return cell;
}
//滑动时触发的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //在拖动界面时,重置imageView的frame
    //设置Y坐标,scrollView的偏移量为Y
    CGFloat offSetY = scrollView.contentOffset.y;
    //下拉时的偏移设为X  初始的偏移量是图片初始高度kImageH,下拉多少距离为offSetY + kImageH(offSetY是负的),
    //除以2是为了效果好一点,向左右两边拉伸
    CGFloat offSetX = (offSetY + kImageH)/2;
    //向下拉动的时候,重置imageView的大小
    if (offSetY < -kImageH) {
        //只能间接的修改frame
        CGRect f = self.imageView.frame;
        //相框的y为scrollView偏移的y
        f.origin.y = offSetY;
        //相框的高度
        f.size.height = -offSetY;
        //相框的X
        f.origin.x = offSetX;
        //相框的宽为屏幕的宽 + 偏移的X(两边)
        f.size.width = [UIScreen mainScreen].bounds.size.width + fabs(offSetX)*2;
        //重新赋值
        self.imageView.frame = f;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
