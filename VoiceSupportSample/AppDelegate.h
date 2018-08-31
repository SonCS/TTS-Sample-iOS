//
//  AppDelegate.h
//  VoiceSupportSample
//
//  Created by csson on 2018. 8. 17..
//  Copyright © 2018년 csson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

