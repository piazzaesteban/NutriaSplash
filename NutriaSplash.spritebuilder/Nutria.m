//
//  Nutria.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 27/06/15.
//  Copyright 2015 Apportable. All rights reserved.
//

#import "Nutria.h"


@implementation Nutria{
    CCSprite * sprite;
}


-(id)init{
    if([super init]){
        self.physicsBody.sensor = true;
    }
    return self;
}

<<<<<<< HEAD
-(void)didLoadFromCCB{
    self.hasJumped = NO;
    
    
}

-(void)pop{
    [sprite setSpriteFrame:[CCSpriteFrame frameWithImageNamed: @"GameAssets/nutria-mitad.png"]];
    sprite.scale = 0.5;
}

-(void)jump{
    [sprite setSpriteFrame:[CCSpriteFrame frameWithImageNamed: @"GameAssets/nutria-saltando.png"]];
    sprite.scale = 1;
}

=======
>>>>>>> 5059237ae7352de4bf11667a85b72cbaadc2e148
@end
