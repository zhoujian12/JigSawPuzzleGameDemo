//
//  DateViewController.m
//  JigSawPuzzleGameDemo
//
//  Created by jianz3 on 2017/4/21.
//  Copyright © 2017年 jianz3. All rights reserved.
//

#import "DateViewController.h"
#import "NSString+ZJDateFormat.h"
#import "UIView+frame.h"

@interface DateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,copy)NSString *timeString;
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) UIButton *returnBtn; ///<

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"XHDateExample";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.returnBtn];
    
//    self.timeString = @"2017-04-16 13:08:06";
    self.timeString = @"2017-04-16 13:08";
    
    //星期
    NSString *time0 = self.timeString.zj_formatWeekDay;
    
    //2017年04月16日
    NSString *time1 = self.timeString.zj_formatNianYueRi;
    
    //2017年04月
    NSString *time2 = self.timeString.zj_formatNianYue;
    
    //04月16日
    NSString *time3 = self.timeString.zj_formatYueRi;
    
    //2017年
    NSString *time4 = self.timeString.zj_formatNian;
    
    //13时08分01秒
    NSString *time5 = self.timeString.zj_formatShiFenMiao;
    
    //13时08分
    NSString *time6 = self.timeString.zj_formatShiFen;
    
    //08分01秒
    NSString *time7 = self.timeString.zj_formatFenMiao;
    
    //2017-04-16
    NSString *time8 = self.timeString.zj_format_yyyy_MM_dd;
    
    //2017-04
    NSString *time9 = self.timeString.zj_format_yyyy_MM;
    
    //04-16
    NSString *time10 = self.timeString.zj_format_MM_dd;
    
    //2017
    NSString *time11 = self.timeString.zj_format_yyyy;
    
    //13:08:06
    NSString *time12 = self.timeString.zj_format_HH_mm_ss;
    
    //13:08
    NSString *time13 = self.timeString.zj_format_HH_mm;
    
    //08:06
    NSString *time14 = self.timeString.zj_format_mm_ss;
    
    self.dataArray = @[time0,time1,time2,time3,time4,time5,time6,time7,time8,time9,time10,time11,time12,time13,time14];
    
    self.returnBtn.frameY = self.view.frame.size.width + 10;
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    view.backgroundColor = [UIColor blueColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, view.frame.size.width-32, view.frame.size.height)];
    lab.text = [NSString stringWithFormat:@"%@ 转换为下面格式↓",self.timeString];
    lab.textColor = [UIColor whiteColor];
    [view addSubview:lab];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
    
}

- (UIButton *)returnBtn{
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setFrame:CGRectMake(0, self.view.frame.size.width + 10, 50, 50)];
        _returnBtn.backgroundColor = [UIColor redColor];
        _returnBtn.titleLabel.hidden = NO;
        [_returnBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_returnBtn.titleLabel setText:@"2返回"];
        [_returnBtn.titleLabel setTextColor:[UIColor blueColor]];
        [_returnBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_returnBtn.titleLabel setFrame:CGRectMake(0, 0, 50, 50)];
        
        [_returnBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}

- (void)btnAction:(id)sender{
   [self dismissViewControllerAnimated:YES completion:^{
   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
