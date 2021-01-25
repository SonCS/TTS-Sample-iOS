//
//  TTSUtil.m
//  VoiceSupportSample
//
//  Created by csson on 2018. 8. 31..
//  Copyright © 2018년 csson. All rights reserved.
//

#import "TTSUtil.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#define DEFAULT_RATE 0.4f
#define DEFAULT_LANGUAGE @"en-US"

@interface TTSUtil() <AVSpeechSynthesizerDelegate> 

@property (nonatomic) AVSpeechSynthesizer *mSpeechSyn;
@property (nonatomic) float speechRate;

@property (nonatomic, strong) UISlider *deviceValueSilder;
@property (nonatomic) float deviceVolume;

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
    
    NSString *langauge = [self languageForString:speakContent];
    NSLog(@"speakContent Langauge : %@", langauge);
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:speakContent];
    utterance.rate = DEFAULT_RATE;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:langauge];
    utterance.volume = 1.0;
    
        self.deviceVolume = [AVAudioSession sharedInstance].outputVolume;
    
    
    [self.mSpeechSyn stopSpeakingAtBoundary:AVSpeechBoundaryWord];
    [self.mSpeechSyn speakUtterance:utterance];
}

#pragma mark -
#pragma mark Function

- (NSString *) languageForString:(NSString *)text
{
    NSString *ret = @"";
    
    if(text.length < 100) {
        ret = (NSString *) CFBridgingRelease(CFStringTokenizerCopyBestStringLanguage((CFStringRef)text, CFRangeMake(0, text.length)));
    }
    else {
        ret = (NSString *) CFBridgingRelease(CFStringTokenizerCopyBestStringLanguage((CFStringRef)text, CFRangeMake(0, 100)));
    }
    
    // 구분하지 못하는 경우 처리
    if(ret == nil || [ret isEqualToString:@"(null)"] || [ret isEqualToString:@"null"]) {
        ret = @"en-US";
    }
    
    return ret;
}

- (UISlider *)deviceValueSilder {
    if(!_deviceValueSilder) {
        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
        UISlider *silder;
        if([volumeView.subviews.firstObject isKindOfClass:[UISlider class]]) {
            _deviceValueSilder = (UISlider *)volumeView.subviews.firstObject;
        }
    }
    
    _deviceValueSilder.value = [AVAudioSession sharedInstance].outputVolume;
    return _deviceValueSilder;
}

- (float) volume {
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectZero];
    UISlider *silder;
    if([volumeView.subviews.firstObject isKindOfClass:[UISlider class]]) {
        silder = (UISlider *)volumeView.subviews.firstObject;
    }
    NSLog(@"outputVolume = %f", [AVAudioSession sharedInstance].outputVolume);
    silder.value = [AVAudioSession sharedInstance].outputVolume;
    NSLog(@"currentValue = %f, maxValue = %f, minValue = %f", silder.value, silder.maximumValue, silder.minimumValue);
    return silder.value;
}

- (void)deviceVolume:(float)volume {
    self.deviceValueSilder.value = volume;
}

#pragma mark -
#pragma mark AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"TTSUtil ::: didStartSpeechUtterance");
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    if([AVAudioSession sharedInstance].outputVolume <= 0.5) {
        [self deviceVolume:0.75];
    }
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance
{
    NSLog(@"TTSUtil ::: didFinishSpeechUtterance");
    [self deviceVolume:self.deviceVolume];
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    
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
    NSLog(@"output Volume = %f", [AVAudioSession sharedInstance].outputVolume);
    NSLog(@"characterRange laction= %ld, length = %ld", characterRange.location, characterRange.length);
    
    
}


@end
