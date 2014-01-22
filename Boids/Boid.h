//
//  Boid.h
//  Boids
//
//  Created by Richard Smith on 30/10/2013.
//  Copyright (c) 2013 Richard Smith. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Boid : SKSpriteNode

@property CGFloat dx;
@property CGFloat dy;
@property CGFloat new_dx;
@property CGFloat new_dy;

@end
