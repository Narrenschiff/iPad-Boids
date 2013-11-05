#iPad-Boids

##Intro
Some simple boids (birdlike object) code for iPad. Hacked it together in a day for a demonstration I had to do and to get familiar with SpriteKit. Doesn't really use much of sprite kit other than the sprite rendering, though. All the boid calculations being done by the BoidManager class in between frame draws, and there's no physics stuff at all.


Boids all act independently but will respond to what they can see other boids doing. This leads to emergent behaviours such as flocking. Each boid will try to -

* Move towards the centre of other boids they can see
* Try to avoid colliding with other boids they can see
* Try to match headings with other boids they can see
* Be attracted or repelled towards touch events on screen

A radius threshold is settable for all of these options, beyond which a boid cannot "see." Additionally, all behaviours (barring touch events) are restricted by a viewing angle centred on each boid's present heading. Weights can be set for each behaviour to change the relative contribution of each behaviour to the boid. These behaviours can be changed from the "settings" button, along with the minimum velocity, momentum, and noise. Attraction to touch events does not observe the viewing angle restriction, and can be weighted negatively to cause repulsion from touch events

The screen does not wrap, and boundaries are handled by fudging the avoidance rule to treat screen edges like collisions with boids. This tends to keep boids on screen, but this is by no means guaranteed, especially if you reduce the weight of avoidance weighting.



##Bugs
Yes.
