//
//  FocusSquare.m
//  ARKit
//
//  Created by szt on 2017/6/13.
//  Copyright © 2017年 AR. All rights reserved.
//

#import "FocusSquare.h"
#import "MaterialUtil.h"
#import "FocusSquareSegment.h"

@interface FocusSquare()
{
    // Original size of the focus square in m.
    float focusSquareSize;
    
    // Thickness of the focus square lines in m.
    float focusSquareThickness;
    
    // Scale factor for the focus square when it is closed, w.r.t. the original size.
    float scaleForClosedSquare;
    
    // Color of the focus square
    UIColor *focusSquareColor; // base yellow
    UIColor *focusSquareColorLight; // light yellow
}

@property(nonatomic, strong)NSMutableArray *segmentArr;

@end

@implementation FocusSquare

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self initData];
        self.opacity = 0.0;
        
        SCNNode * node = [self setupFocusSquareNode];
        [self addChildNode:node];
        self.position = SCNVector3Make(0.0, -1.0, -1.0);
    }
    
    return self;
}

- (void)initData
{
    focusSquareSize = 0.17;
    focusSquareThickness = 0.018;
    scaleForClosedSquare = 0.97;
    
    focusSquareColor = [UIColor colorWithRed:1 green:0.8288275599 blue:0 alpha:1]; // base yellow
    focusSquareColorLight = [UIColor colorWithRed:1 green:0.9312674403 blue:0.4846551418 alpha:1]; // light yellow
    
    _segmentArr = [NSMutableArray array];
}

/*
 The focus square consists of eight segments as follows, which can be individually animated.
 
     s1  s2
     _   _
 s3 |     | s4
 
 s5 |     | s6
     -   -
     s7  s8
 */
- (SCNNode *)setupFocusSquareNode
{
    float sl = 0.5;  // segment length
    float st = focusSquareThickness;
    float c = focusSquareThickness / 2; // correction to align lines perfectly
    
    SCNNode *s1 = [[FocusSquareSegment alloc] initFocusSquareSegment:@"s1" wigth:sl thickness:st color:focusSquareColor vertical:false];
    SCNNode *s2 = [[FocusSquareSegment alloc] initFocusSquareSegment:@"s2" wigth:sl thickness:st color:focusSquareColor vertical:false];
    SCNNode *s3 = [[FocusSquareSegment alloc] initFocusSquareSegment:@"s3" wigth:sl thickness:st color:focusSquareColor vertical:true];
    SCNNode *s4 = [[FocusSquareSegment alloc] initFocusSquareSegment:@"s4" wigth:sl thickness:st color:focusSquareColor vertical:true];
    SCNNode *s5 = [[FocusSquareSegment alloc] initFocusSquareSegment:@"s5" wigth:sl thickness:st color:focusSquareColor vertical:true];
    SCNNode *s6 = [[FocusSquareSegment alloc] initFocusSquareSegment:@"s6" wigth:sl thickness:st color:focusSquareColor vertical:true];
    SCNNode *s7 = [[FocusSquareSegment alloc] initFocusSquareSegment:@"s7" wigth:sl thickness:st color:focusSquareColor vertical:false];
    SCNNode *s8 = [[FocusSquareSegment alloc] initFocusSquareSegment:@"s8" wigth:sl thickness:st color:focusSquareColor vertical:false];
    s1.position = SCNVector3Make(s1.position.x -(sl / 2 - c), s1.position.y -(sl - c), s1.position.z + 0);
    s2.position = SCNVector3Make(s2.position.x + sl / 2 - c, s2.position.y -(sl - c), s2.position.z + 0);
    s3.position = SCNVector3Make(s3.position.x -sl, s3.position.y -sl / 2, s3.position.z + 0);
    s4.position = SCNVector3Make(s4.position.x + sl, s4.position.y -sl / 2, s4.position.z + 0);
    s5.position = SCNVector3Make(s5.position.x -sl, s5.position.y + sl / 2, s5.position.z + 0);
    s6.position = SCNVector3Make(s6.position.x + sl, s6.position.y + sl / 2, s6.position.z + 0);
    s7.position = SCNVector3Make(s7.position.x -(sl / 2 - c), s7.position.y + sl - c, s7.position.z + 0);
    s8.position = SCNVector3Make(s8.position.x + sl / 2 - c, s8.position.y + sl - c, s8.position.z + 0);
    
    SCNPlane *fillPlane = [SCNPlane planeWithWidth:1.0 - st * 2 + c height:1.0 - st * 2 + c];
    SCNMaterial *material = [MaterialUtil material:focusSquareColorLight respondsToLighting:false];
    fillPlane.firstMaterial = material;
    SCNNode *fillPlaneNode = [SCNNode nodeWithGeometry:fillPlane];
    fillPlaneNode.name = @"fillPlane";
    fillPlaneNode.opacity = 1.0;
    
    SCNNode *planeNode = [SCNNode node];
    planeNode.eulerAngles = SCNVector3Make(M_PI / 2.0, 0, 0); // Horizontal
    planeNode.scale = SCNVector3Make(focusSquareSize * scaleForClosedSquare, focusSquareSize * scaleForClosedSquare, focusSquareSize * scaleForClosedSquare);
    [planeNode addChildNode:s1];
    [planeNode addChildNode:s2];
    [planeNode addChildNode:s3];
    [planeNode addChildNode:s4];
    [planeNode addChildNode:s5];
    [planeNode addChildNode:s6];
    [planeNode addChildNode:s7];
    [planeNode addChildNode:s8];
    [planeNode addChildNode:fillPlaneNode];
    
    [_segmentArr addObject:s1];
    [_segmentArr addObject:s2];
    [_segmentArr addObject:s3];
    [_segmentArr addObject:s4];
    [_segmentArr addObject:s5];
    [_segmentArr addObject:s6];
    [_segmentArr addObject:s7];
    [_segmentArr addObject:s8];
    [_segmentArr addObject:fillPlaneNode];
    
    // Always render focus square on top
//    [self renderOnTop:planeNode];
    
    return planeNode;
}

- (void)renderOnTop:(SCNNode *)node
{
    node.renderingOrder = 2;
    
    SCNGeometry * geom = node.geometry;
    if (geom) {
        for (SCNMaterial *material in geom.materials) {
            material.readsFromDepthBuffer = false;
        }
    }
    for (SCNNode *child in node.childNodes) {
        [self renderOnTop:child];
    }
}

- (void)hide
{
    SCNNode *node  =  _segmentArr.lastObject;
    if (node.opacity == 1.0) {
        [node runAction:[SCNAction fadeOutWithDuration:0.5]];
    }
}

- (void)unhide
{
    self.opacity = 1.0;
    
    SCNNode *node  = _segmentArr.lastObject;
    if (node.opacity == 0.0) {
        [node runAction:[SCNAction fadeInWithDuration:0.5]];
    }
}

- (void)update:(SCNVector3)worldPos
{
    self.position = worldPos;
}

- (BOOL)isInPlane
{
    SCNNode *node = _segmentArr.lastObject;
    
    return node.opacity;
}
@end
