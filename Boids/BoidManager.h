//
//  BoidManager.h
//  Boids
//
//  Created by Richard Smith on 30/10/2013.
//  Copyright (c) 2013 Richard Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Boid.h"

@interface BoidManager : NSObject

-(BoidManager *) initWithCapacity:(NSUInteger)n;

-(void) nextTimeStep:(NSTimeInterval)deltat;

-(CGPoint) getBoidLocationForPosition:(NSUInteger) n;

-(CGFloat) getBoidOrientationForPosition:(NSUInteger) n;

@property CGFloat maxBoidVelocity;
@property CGFloat minBoidVelocity;
@property CGFloat momentumFactor;
@property CGFloat copyRadius;
@property CGFloat centroidRadius;
@property CGFloat avoidanceRadius;
@property CGFloat viewingAngle;
@property CGFloat copyWeight;
@property CGFloat centroidWeight;
@property CGFloat avoidanceWeight;
@property CGFloat height;
@property CGFloat width;

@end
