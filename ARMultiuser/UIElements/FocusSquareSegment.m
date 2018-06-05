//
//  FocusSquareSegment.m
//  ARKit
//
//  Created by szt on 2017/6/13.
//  Copyright © 2017年 AR. All rights reserved.
//

#import "FocusSquareSegment.h"
#import "MaterialUtil.h"

@implementation FocusSquareSegment

- (instancetype)initFocusSquareSegment:(NSString *)name wigth:(float)width thickness:(float)thickness color:(UIColor *)color vertical:(BOOL)vertical
{
    self = [super init];
    
    if (self) {
        SCNMaterial *material = [MaterialUtil material:color respondsToLighting:false];
        
        SCNPlane *plane;
        if (vertical) {
            plane = [SCNPlane planeWithWidth:thickness height:width];
        }else{
            plane = [SCNPlane planeWithWidth:width height:thickness];
        }
        
        plane.firstMaterial = material;
        self.geometry = plane;
        self.name = name;
    }
    
    return self;
}

- (void)openByDirection:(Direction)direction newLength:(float)newLength
{
    if (![[self.geometry class] isEqual:[SCNPlane class]]) {
        return;
    }
    
    SCNPlane * p = (SCNPlane *)self.geometry;
    
    if (direction == left || direction == right) {
        p.width = newLength;
    }else{
        p.height = newLength;
    }
    
    float value;
    switch (direction) {
        case left:
            value = (0.5 / 2 - p.width / 2);
            self.position = SCNVector3Make(self.position.x - value, self.position.y, self.position.z);
            break;
        case right:
            value = (0.5 / 2 - p.width / 2);
            self.position = SCNVector3Make(self.position.x + value, self.position.y, self.position.z);
            break;
        case up:
            value = (0.5 / 2 - p.height / 2);
            self.position = SCNVector3Make(self.position.x, self.position.y - value, self.position.z);
            break;
        case down:
            value = (0.5 / 2 - p.height / 2);
            self.position = SCNVector3Make(self.position.x, self.position.y + value, self.position.z);
            break;
        default:
            break;
    }
}

- (void)closeByDirection:(Direction)direction
{
    if (![[self.geometry class] isEqual:[SCNPlane class]]) {
        return;
    }
    
    SCNPlane * p = (SCNPlane *)self.geometry;
    
    float oldLength;
    if (direction == left || direction == right) {
        oldLength = p.width;
        p.width = 0.5;
    }else{
        oldLength = p.height;
        p.height = 0.5;
    }
    
    float value;
    switch (direction) {
        case left:
            value = (0.5 / 2 - oldLength / 2);
            self.position = SCNVector3Make(self.position.x - value, self.position.y, self.position.z);
            break;
        case right:
            value = (0.5 / 2 - oldLength / 2);
            self.position = SCNVector3Make(self.position.x + value, self.position.y, self.position.z);
            break;
        case up:
            value = (0.5 / 2 - oldLength / 2);
            self.position = SCNVector3Make(self.position.x, self.position.y - value, self.position.z);
            break;
        case down:
            value = (0.5 / 2 - oldLength / 2);
            self.position = SCNVector3Make(self.position.x, self.position.y + value, self.position.z);
            break;
        default:
            break;
    }
}

@end
