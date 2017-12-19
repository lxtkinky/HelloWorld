//
//  SecondViewController.m
//  HelloWorld
//
//  Created by test on 17/12/19.
//  Copyright © 2017年 test. All rights reserved.
//

#import "SecondViewController.h"
#import "Masonry.h"

@interface SecondViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    
//    [_delegateSubject sendNext:@"hello"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateViewConstraints{
//    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(50);
//    }];
    
    [super updateViewConstraints];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark getter setter

- (UIButton *)button{
    if (_button == nil) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor greenColor];
        [_button setTitle:@"load" forState:UIControlStateNormal];
        _button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            NSLog(@"%@", input);
            [self.delegateSubject sendNext:@"hello"];
            return [RACSignal empty];
        }];
    }
    
    return _button;
}


@end
