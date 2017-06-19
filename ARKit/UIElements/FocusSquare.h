//
//  FocusSquare.h
//  ARKit
//
//  Created by szt on 2017/6/13.
//  Copyright © 2017年 AR. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface FocusSquare : SCNNode

- (void)hide;

- (void)unhide;

- (void)update:(SCNVector3)worldPos;

- (BOOL)isInPlane;

@end
