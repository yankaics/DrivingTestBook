//
//  FirstViewController.m
//  DrivingTestBook
//
//  Created by TTS on 15/8/28.
//  Copyright (c) 2015年 TTS. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "FirstTableCellModel.h"
#import "TestSelectViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;    //tableView 将从头部导航栏下开始计算xy坐标
    [self createTableViewUI];
    [self createView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @author mangues, 15-08-28 13:08:45
 *
 *  初始化数据
 */
- (void)initData{
    NSArray *arrayName = @[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真模拟考试"];
    _dataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        FirstTableCellModel *model = [[FirstTableCellModel alloc] init];
        model.imageUrl = [NSString stringWithFormat:@"%d.png",i+7];
        model.cellName = arrayName[i];
        [_dataArray addObject:model];
    }
    
    
}


/**
 *  @author mangues, 15-08-28 11:08:08
 *
 *  初始化tableView
 */

-(void)createTableViewUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //设置tableView不可滚动
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}


-(void)createView{
    NSArray *array = @[@"我的错题",@"我的收藏",@"我的成绩",@"练习统计"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150 , self.view.frame.size.height-64-140,300,30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"···················我的考试分析···················";
    [self.view addSubview:label];
    
    for (int i=0; i<4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",12+i]] forState:UIControlStateNormal];
         [self.view addSubview:btn];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-25, 60, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = array[i];
        lab.font = [UIFont boldSystemFontOfSize:13];
        [self.view addSubview:lab];
    }
    
    
    
    
}





/**
 *  @author mangues, 15-08-28 13:08:07
 *
 *  cell的个数
 *
 *  @param tableView
 *  @param section
 *
 *  @return
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

/**
 *  @author mangues, 15-08-28 13:08:36
 *
 *  section的个数
 *
 *  @param tableView
 *
 *  @return
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


/**
 *  @author mangues, 15-08-28 13:08:51
 *
 *  生成cell
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"FirstTableViewCell";
    FirstTableViewCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
//        cell=[[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //利用xib生成的cell
        cell= [[[NSBundle mainBundle] loadNibNamed: cellIdentifier owner:self options:nil] lastObject];
    }
    
    cell.model = _dataArray[indexPath.row];
  
    return cell;
}
/**
 *  @author mangues, 15-08-28 14:08:47
 *
 *  设置行高
 *
 *  @param tableView
 *  @param indexPath
 *
 *  @return
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}


/**
 *  @author mangues, 15-09-01 11:09:42
 *
 *  点击事件
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://章节练习
        {
            TestSelectViewController *collor = [[TestSelectViewController alloc] init];
            collor.title = @"章节练习";
            UIBarButtonItem* item = [[UIBarButtonItem alloc] init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:collor animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}



-(void)viewDidLayoutSubviews
{
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
