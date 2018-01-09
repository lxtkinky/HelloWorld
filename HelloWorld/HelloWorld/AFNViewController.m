//
//  AFNViewController.m
//  HelloWorld
//
//  Created by test on 17/12/20.
//  Copyright © 2017年 test. All rights reserved.
//

#import "AFNViewController.h"
//#import <ReactiveObjC/ReactiveObjC.h>
//#import <AFNetworking/AFNetworking.h>


@interface AFNViewController ()
@property (nonatomic, strong) RACCommand *networkCommand;

@end

@implementation AFNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
    
    [self testNetWork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)testNetWork{
   
    
    // Dispose of any resources that can be recreated.
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://sanatorium.appvv.com/api/login/";
    NSDictionary *param = @{@"username" : @"lixt",
                            @"logintype" : @"pwd",
                            @"password" : @"123456",
                            @"code" : @"123456"};
    [manager POST:urlStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"====%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (RACCommand *)networkCommand{
    if (!_networkCommand) {
        _networkCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [RACSignal empty];
        }];
    }
    return _networkCommand;
}

@end
