//
//  ViewController.m
//  VoiceSupportSample
//
//  Created by csson on 2018. 8. 17..
//  Copyright © 2018년 csson. All rights reserved.
//

#import "ViewController.h"
#import "TTSUtil.h"

@interface ViewController () 
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction_Speech:(id)sender {
    [[TTSUtil sharedInstance] Exec_Speak:@"Hello, World."];
}

@end
