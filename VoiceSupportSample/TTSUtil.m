//
//  TTSUtil.m
//  VoiceSupportSample
//
//  Created by csson on 2018. 8. 31..
//  Copyright © 2018년 csson. All rights reserved.
//

#import "TTSUtil.h"
#import <AVFoundation/AVFoundation.h>

#define DEFAULT_RATE 0.4f
#define DEFAULT_LANGUAGE @"en-US"

@interface TTSUtil() <AVSpeechSynthesizerDelegate> 

@property (nonatomic) AVSpeechSynthesizer *mSpeechSyn;
@property (nonatomic) float speechRate;


@end

@implementation TTSUtil

+ (TTSUtil *) sharedInstance
{
    static TTSUtil *singletonCalss = nil;
    
    if(singletonCalss == nil) {
        @synchronized(self) {
            if(singletonCalss == nil) {
                singletonCalss = [[self alloc] init];
            }
        }
    }
    
    return singletonCalss;
}

- (id) init
{
    self = [super init];
    
    if(self) {
        NSLog(@"Create TTS Util");
        if(!self.mSpeechSyn) {
            self.mSpeechSyn = [[AVSpeechSynthesizer alloc] init];
            self.mSpeechSyn.delegate = self;
        }
    }
    
    return self;
}

- (void) Exec_Speak:(NSString *)speakContent
{
    if(speakContent == nil) {
        return;
    }
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:speakContent];
    utterance.rate = DEFAULT_RATE;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:DEFAULT_LANGUAGE];
    
    [self.mSpeechSyn speakUtterance:utterance];
}

#pragma mark -
#pragma mark AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"TTSUtil ::: didStartSpeechUtterance");
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"TTSUtil ::: didFinishSpeechUtterance");
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"TTSUtil ::: didPauseSpeechUtterance");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"TTSUtil ::: didContinueSpeechUtterance");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"TTSUtil ::: didCancelSpeechUtterance");
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"TTSUtil ::: willSpeakRangeOfSpeechString");
}


@end
