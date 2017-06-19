//
//  Player.h
//  SceneKitTest
//
//  Created by szt on 2017/6/9.
//  Copyright © 2017年 Game. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SceneKit/SceneKit.h>

@interface Player : NSObject

- (instancetype)initWithModelScene:(SCNScene *)scene;

/** Stores a node for the whole character model */
@property (nonatomic, strong) SCNNode *characterNode;

/** Stores all the nodes associated with the model */
@property (nonatomic, strong) NSArray *nodes;

- (void)addAnimates:(NSMutableArray *)arr forKey:(NSString *)key;

- (void)playAnimatesForkey:(NSString *)key;

- (void)removeAnimatesForkey:(NSString *)key;

@end
