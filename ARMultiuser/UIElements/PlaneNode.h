//
//  PlaneNode.h
//  AR_Test
//
//  Created by Damian Stewart on 06/06/2017.
//  Copyright © 2017 ds. All rights reserved.
//

#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface PlaneNode : SCNNode

@property (strong, readwrite, atomic) SCNNode* shapeNode;

- (void)updateShapeNodeWithAnchor:(ARPlaneAnchor*)plane;

@end
