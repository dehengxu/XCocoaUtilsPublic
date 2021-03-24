//
//  ViewController.m
//  Demo
//
//  Created by NicholasXu on 15/9/1.
//  Copyright (c) 2015年 Deheng.Xu. All rights reserved.
//

#import "ViewController.h"
#import "Logs.h"
//#import <XCocoaUtilsPublic/XCocoaUtilsPublic.h>
@import XCocoaUtilsPublic;
using namespace nxcxx::con;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
	mainvcLog(@"-->>%s", __func__);
    NSLock*lock = [NSLock new];
    GenLock<NSLock*>(lock);
    //Close logging
//    [log_mainvc setLoggingEnabled:false];

    UIImageView *imgv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"erik-unsplash.jpg"]];

    [self.view addSubview:imgv];
    imgv.frame = (CGRect){0, 0, fmin(self.view.width, self.view.height), fmin(self.view.width, self.view.height)};
    imgv.center = self.view.center;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *img = [UIImage imageNamed:@"erik-unsplash.jpg"];
        NSData *dt = nil;
        CGFloat ratio = 0.7;
        for (int i = 0; i < 0; i++) {
            dt =
            //UIImagePNGRepresentation(img);
            UIImageJPEGRepresentation(img, ratio);
            //[NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"erik" ofType:@""]];
            //[NSData dataWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"erik-unsplash" ofType:@"jpg"]];
            //dt = [@"HeyJude." dataUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"%d dt size: %lu, %lu(kb)", i, dt.length, (dt.length >> 10)  );
            img = [UIImage imageWithData:dt];
            dispatch_async(dispatch_get_main_queue(), ^{
                [imgv setImage:img];
            });
            //ratio = 1.0;
        }

    });

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
