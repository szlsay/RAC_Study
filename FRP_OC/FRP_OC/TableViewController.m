//
//  TableViewController.m
//  FRP_OC
//
//  Created by ST on 16/12/8.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
/** 1. */
@property(nonatomic, strong)NSArray *arrayVC;
@end

@implementation TableViewController

#pragma mark - --- 1.init 生命周期 ---
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - --- 2.delegate 视图委托 ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayVC.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.arrayVC[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *vc = [NSClassFromString(self.arrayVC[indexPath.row]) new];
    if ([vc isKindOfClass:[UIViewController class]]) {
        vc.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - --- 3.event response 事件相应 ---

#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--
- (NSArray *)arrayVC
{
    return @[@"SignalController", @"SignalController0", @"RACSubjectController", @"RACReplaySubjectController", @"RACSequenceController",@"RACCommandController",@"RACMulticastConnectionController",@"RACCommonController", @"RACMacroController"];
}

@end
