//
//  ViewController.m
//  HelloWorld
//
//  Created by test on 17/12/18.
//  Copyright © 2017年 test. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "SecondViewController.h"
#import "SDWebImageController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ViewModel *viewModel;
@property (nonatomic, strong) UIAlertController *action;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.viewModel requestDataWithPull:YES];
    });
    
    
    
}


- (void)updateViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [super updateViewConstraints];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"the %ld line", indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        [self presentViewController:self.action animated:YES completion:nil];
        return;
    }
    
    if (indexPath.row == 3) {
        SDWebImageController *webImageVC = [[SDWebImageController alloc] init];
        [self.navigationController pushViewController:webImageVC animated:YES];
        return;
    }
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.delegateSubject = [RACSubject subject];
    @weakify(self)
    [secondVC.delegateSubject subscribeNext:^(id x) {
        @strongify(self)
        [self.viewModel requestDataWithPull:NO];
        NSLog(@"receive singal!-->%@", x);
    }];
    
    [self.navigationController pushViewController:secondVC animated:YES];
    
}


#pragma mark - getter setter

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor greenColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (ViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[ViewModel alloc] init];
        [_viewModel.tableSubject subscribeNext:^(id x) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }];
    }
    
    return _viewModel;
}


- (UIAlertController *)action{
    if (_action == nil) {
        _action = [UIAlertController alertControllerWithTitle:@"action" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [_action addAction:[UIAlertAction actionWithTitle:@"yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"yes");
        }]];
    }
    return _action;
}


@end
