//
//  Gameplay.h
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCPhysics+ObjectiveChipmunk.h"

#import "Pool.h"

@interface Gameplay : CCNode <CCPhysicsCollisionDelegate>

@property (nonatomic, assign) int level;

@end
