//
//  Ball.m
//  ARKit
//
//  Created by szt on 2017/6/12.
//  Copyright © 2017年 AR. All rights reserved.
//

#import "Ball.h"

@implementation Ball

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setupBall];
    }
    
    return self;
}

- (void)setupBall
{
    SCNSphere *sphere = [[SCNSphere alloc] init];
    sphere.radius = 0.025;
    
    self.geometry = sphere;
    self.physicsBody = [SCNPhysicsBody dynamicBody];
    self.physicsBody.affectedByGravity = true;
    
    self.physicsBody.mass = 0.5;
    self.physicsBody.friction = 2;
    self.physicsBody.contactTestBitMask = 1;
    
    self.geometry.firstMaterial.diffuse.contents = [UIColor blueColor];
}

@end
