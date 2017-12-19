//
//  SecondViewController.h
//  HelloWorld
//
//  Created by test on 17/12/19.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SecondViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSubject;

@end
