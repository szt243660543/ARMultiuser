//
//  FocusSquareSegment.h
//  ARKit
//
//  Created by szt on 2017/6/13.
//  Copyright © 2017年 AR. All rights reserved.
//

#import <SceneKit/SceneKit.h>

typedef NS_ENUM(NSInteger, Direction) {
    up,
    down,
    left,
    right,
};

@interface FocusSquareSegment : SCNNode

- (instancetype)initFocusSquareSegment:(NSString *)name wigth:(float)width thickness:(float)thickness color:(UIColor *)color vertical:(BOOL)vertical;

- (void)openByDirection:(Direction)direction newLength:(float)newLength;

- (void)closeByDirection:(Direction)direction;
@end
