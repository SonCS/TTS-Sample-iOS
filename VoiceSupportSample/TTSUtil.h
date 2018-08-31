//
//  TTSUtil.h
//  VoiceSupportSample
//
//  Created by csson on 2018. 8. 31..
//  Copyright © 2018년 csson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTSUtil : NSObject

+ (TTSUtil *) sharedInstance;

- (void) Exec_Speak:(NSString *)speakContent;

@end
