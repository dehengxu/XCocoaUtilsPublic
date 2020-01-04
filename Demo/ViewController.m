//
//  ViewController.m
//  Demo
//
//  Created by NicholasXu on 15/9/1.
//  Copyright (c) 2015年 Deheng.Xu. All rights reserved.
//

#import "ViewController.h"
#import "Logs.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
	mainvcLog(@"-->>%s", __func__);
    //Close logging
//    [log_mainvc setLoggingEnabled:false];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    mainvcLog(@"-->>%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
