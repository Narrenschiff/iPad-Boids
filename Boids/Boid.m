//
//  Boid.m
//  Boids
//
//  Created by Richard Smith on 30/10/2013.
//  Copyright (c) 2013 Richard Smith. All rights reserved.
//

#import "Boid.h"

@implementation Boid

-(id)init
{
    if (self = [super initWithImageNamed:@"Boid"])
    {
        self.size = CGSizeMake(10.0, 15.0);
    }
    return self;
}

@end
