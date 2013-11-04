//
//  MyScene.h
//  Boids
//

//  Copyright (c) 2013 Richard Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "BoidManager.h"

@interface MyScene : SKScene

@property (strong, atomic) BoidManager *boidManager;

@end
