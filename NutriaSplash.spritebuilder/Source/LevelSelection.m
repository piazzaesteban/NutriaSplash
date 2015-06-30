//
//  LevelSelection.m
//  NutriaSplash
//
//  Created by Esteban Piazza Vázquez on 28/06/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LevelSelection.h"

@implementation LevelSelection{
    CCButton* _playButton;
    
}

-(id)init{
    if (self = [super init]) {
    }
    return self;
}

-(void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    _playButton.enabled = false;
}

@end
