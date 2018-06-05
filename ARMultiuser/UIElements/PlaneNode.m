//
//  PlaneNode.m
//  AR_Test
//
//  Created by Damian Stewart on 06/06/2017.
//  Copyright © 2017 ds. All rights reserved.
//

#import "PlaneNode.h"

@interface PlaneNode()
{
    SCNPlane *planeGeometry;
}

@end

@implementation PlaneNode

- (id)init
{
    if (self = [super init]) {
        planeGeometry = [[SCNPlane alloc] init];
        planeGeometry.width = 1.0;
        planeGeometry.height = 1.0;
        
        planeGeometry.firstMaterial.diffuse.contents = [UIImage imageNamed:@"grass.jpg"];
        self.shapeNode = [SCNNode nodeWithGeometry:planeGeometry];
        self.shapeNode.physicsBody = [SCNPhysicsBody staticBody];
        
        [self addChildNode:self.shapeNode];
    }
    return self;
}

// As the user moves around the extend and location of the plane may be updated.
- (void)updateShapeNodeWithAnchor:(ARPlaneAnchor*)plane
{
    planeGeometry.width = [plane extent].x;
    planeGeometry.height = [plane extent].z;
    
    GLfloat x = plane.center.x;
    GLfloat y = plane.center.y - 0.001;
    GLfloat z = plane.center.z;
    
    self.shapeNode.position = SCNVector3Make(x, y, z);
    self.shapeNode.rotation = SCNVector4Make(1, 0, 0, -M_PI_2);
    
    self.shapeNode.physicsBody = [SCNPhysicsBody staticBody];
}

@end

