//
//  MyScene.m
//  Boids
//
//  Created by Richard Smith on 30/10/2013.
//  Copyright (c) 2013 Richard Smith. All rights reserved.
//

#import "MyScene.h"
#import "BoidManager.h"

#define N_BOIDS 200

@interface MyScene ()

@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *selectedNode;

@end

@implementation MyScene

CFTimeInterval lastUpdateTimeInterval;
CFTimeInterval timeSinceLast;
BoidManager *boidManager;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Satan";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        //[self addChild:myLabel];
        boidManager = [[BoidManager alloc] initWithCapacity:N_BOIDS];
        for (uint i = 0; i < N_BOIDS; i++) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Laser"];
            
            CGSize spriteSize = CGSizeMake(10.0, 10.0);
            
            sprite.size = spriteSize;
            
            sprite.position = [boidManager getBoidLocationForPosition:i];
            sprite.zRotation = [boidManager getBoidOrientationForPosition:i];
            
            
            NSLog(@"Added boid %i at %f,%f", i, sprite.position.x, sprite.position.y);
            
//            SKAction *action1 = [SKAction rotateByAngle:M_PI duration:1];
//            SKAction *action2 = [SKAction scaleBy:1.1 duration: 1];
//            
//            SKAction *action = [SKAction group:@[action1, action2]];
//            
//            [sprite runAction:[SKAction repeatActionForever:action]];
//            
            [self addChild:sprite];
            
            
        }
    }
    return self;
}

-(void)didEvaluateActions
{
    [boidManager nextTimeStep:0.1];
    for (uint i = 0; i < [self.children count]; i++) {
        SKNode *s = [self.children objectAtIndex:i];
        s.position = [boidManager getBoidLocationForPosition:i];
        s.zRotation = [boidManager getBoidOrientationForPosition:i];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Laser"];
        
        CGSize spriteSize = CGSizeMake(10.0, 10.0);
        
        sprite.size = spriteSize;
        
        sprite.position = location;
        
        NSLog(@"%f %f",location.x,location.y);
        
        SKAction *action1 = [SKAction rotateByAngle:M_PI duration:1];
        SKAction *action2 = [SKAction scaleBy:1.1 duration: 1];
        
        SKAction *action = [SKAction group:@[action1, action2]];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    timeSinceLast = currentTime - lastUpdateTimeInterval;
    lastUpdateTimeInterval = currentTime;

}

@end
