//
//  ResManager.m
//  ARKit
//
//  Created by szt on 2017/6/16.
//  Copyright © 2017年 AR. All rights reserved.
//

#import "ResManager.h"
#import <SceneKit/SceneKit.h>

@implementation ResManager

+ (NSMutableArray *)loadActionResource:(NSString *)fileName
{
    NSMutableArray * animations = [NSMutableArray array];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    
    SCNSceneSource *sceneSource = [SCNSceneSource sceneSourceWithURL:url options:@{SCNSceneSourceAnimationImportPolicyKey:SCNSceneSourceAnimationImportPolicyPlayRepeatedly} ];
    
    NSArray *animationIds = [sceneSource identifiersOfEntriesWithClass:[CAAnimation class]];
    
    for(NSString *eachId in animationIds){
        CAAnimation *animation = [sceneSource entryWithIdentifier:eachId withClass:[CAAnimation class]];
        [animations addObject:animation];
    }
    
    return animations;
}

@end
