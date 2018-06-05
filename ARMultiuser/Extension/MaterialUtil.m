//
//  SCNMaterial+Extension.m
//  ARKit
//
//  Created by szt on 2017/6/13.
//  Copyright © 2017年 AR. All rights reserved.
//

#import "MaterialUtil.h"

@implementation MaterialUtil

+ (SCNMaterial *)material:(UIColor *)diffuse respondsToLighting:(BOOL)isLight
{
    SCNMaterial *material = [SCNMaterial material];
    material.diffuse.contents = diffuse;
    [material setDoubleSided:true];
    
    if (isLight) {
        material.locksAmbientWithDiffuse = true;
    }else{
        material.ambient.contents = [UIColor blackColor];
        material.lightingModelName = @"SCNLightingModelBlinn";
        material.emission.contents = diffuse;
    }
    
    return material;
}

@end
