//
//  SCNMaterial+Extension.h
//  ARKit
//
//  Created by szt on 2017/6/13.
//  Copyright © 2017年 AR. All rights reserved.
//

#import <SceneKit/SceneKit.h>

@interface MaterialUtil :NSObject

+ (SCNMaterial *)material:(UIColor *)diffuse respondsToLighting:(BOOL)isLight;

@end
