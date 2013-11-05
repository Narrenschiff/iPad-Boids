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
@synthesize boidManager;

SKNode *boidRootNode;
SKNode *touchTargets;
NSMutableSet *attractors;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
//        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        
//        myLabel.text = @"Satan";
//        myLabel.fontSize = 30;
//        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame));
//        
//        //[self addChild:myLabel];
        boidManager = [[BoidManager alloc] initWithCapacity:N_BOIDS];
        boidRootNode = [[SKNode alloc] init];
        boidRootNode.position = CGPointMake(0,0);
        touchTargets = [[SKNode alloc] init];
        touchTargets.position = CGPointMake(0,0);
        [self addChild:boidRootNode];
        [self addChild:touchTargets];
        for (uint i = 0; i < N_BOIDS; i++) {
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Boid"];
            
            CGSize spriteSize = CGSizeMake(10.0, 15.0);
            
            sprite.size = spriteSize;
            
            sprite.position = [boidManager getBoidLocationForPosition:i];
            sprite.zRotation = [boidManager getBoidOrientationForPosition:i];
            
            [boidRootNode addChild:sprite];
        }
    }
    return self;
}

-(void)didEvaluateActions
{
    [boidManager nextTimeStep: timeSinceLast < 0.5 ? timeSinceLast : 0.5 withAttractors:attractors];
    for (uint i = 0; i < [boidRootNode.children count]; i++) {
        SKNode *s = [boidRootNode.children objectAtIndex:i];
        s.position = [boidManager getBoidLocationForPosition:i];
        s.zRotation = [boidManager getBoidOrientationForPosition:i];
    }
    [touchTargets removeChildrenInArray:touchTargets.children];
    for (NSValue *a in attractors) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Target"];
        CGSize spriteSize = CGSizeMake(125.0, 125.0);
        sprite.size = spriteSize;
        sprite.position = [a CGPointValue];
        [touchTargets addChild:sprite];
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    attractors = [self attractorsWithUITouches:touches];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    attractors = [self attractorsWithUITouches:touches];
}

- (NSMutableSet *) attractorsWithUITouches:(NSSet *)touches
{
    NSMutableSet *attractors = [NSMutableSet setWithCapacity:[touches count]];
    for (UITouch *t in touches) {
        if (t.phase == UITouchPhaseEnded || t.phase == UITouchPhaseCancelled) continue;
        CGPoint p = [t locationInNode:self];
        [attractors addObject:[NSValue valueWithCGPoint:p]];
        //NSLog(@"Touch at %f,%f", p.x, p.y);
    }
    return attractors;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    attractors = [self attractorsWithUITouches:touches];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    attractors = [self attractorsWithUITouches:touches];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    timeSinceLast = currentTime - lastUpdateTimeInterval;
    lastUpdateTimeInterval = currentTime;

}

@end
