//
//  Box.m
//  ARKit
//
//  Created by szt on 2017/6/12.
//  Copyright © 2017年 AR. All rights reserved.
//

#import "Box.h"

@implementation Box

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setupBox];
    }
    
    return self;
}

- (void)setupBox
{
    SCNBox *box = [SCNBox boxWithWidth:0.1 height:0.1 length:0.1 chamferRadius:0.0];
    self.geometry = box;
    
    SCNPhysicsBody *physicsBody = [SCNPhysicsBody bodyWithType:SCNPhysicsBodyTypeDynamic shape:[SCNPhysicsShape shapeWithGeometry:box options:nil]];
    self.physicsBody = physicsBody;
    self.physicsBody.affectedByGravity = false;
    
    self.geometry.firstMaterial.diffuse.contents = [UIColor redColor];
}
    

@end
