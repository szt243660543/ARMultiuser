//
//  Player.m
//  SceneKitTest
//
//  Created by szt on 2017/6/9.
//  Copyright © 2017年 Game. All rights reserved.
//

#import "Player.h"

@interface Player()

@property(nonatomic, strong)NSMutableDictionary *actions;

@end

@implementation Player

- (instancetype)initWithModelScene:(SCNScene *)scene
{
    self = [super init];
    
    if (self) {
        NSMutableArray *nodesMut = [NSMutableArray array];
        [nodesMut addObjectsFromArray:[scene.rootNode childNodes]];
        _nodes = [NSArray arrayWithArray:nodesMut];
        
        /* Store character data */
        _characterNode = [SCNNode node];
        for (SCNNode * eachNode in _nodes) {
            [_characterNode addChildNode:eachNode];
        }        
        _actions = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void)addAnimates:(NSMutableArray *)arr forKey:(NSString *)key
{
    [_actions setObject:arr forKey:key];
}

- (void)playAnimatesForkey:(NSString *)key
{
    int i = 1;
    NSMutableArray * _animations = [_actions objectForKey:key];
    for(CAAnimation *animation in _animations){
        NSString *key = [NSString stringWithFormat:@"aminate_%d", i];
        [self.characterNode addAnimation:animation forKey:key];
        i++;
    }
}

- (void)removeAnimatesForkey:(NSString *)key
{
    NSMutableArray * _idleAnimations = [_actions objectForKey:key];
    for(int i = 1; i <= [_idleAnimations count]; i++){
        NSString *key = [NSString stringWithFormat:@"aminate_%d", i];
        [self.characterNode removeAnimationForKey:key];
    }
}

@end
