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
@property (weak, nonatomic) IBOutlet UITextField *tfSpeechContent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // default context
    self.tfSpeechContent.text = @"Hello, TTS World.";
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction_Speech:(id)sender {
    NSString *content = self.tfSpeechContent.text;
    [[TTSUtil sharedInstance] Exec_Speak:content];
}

@end
