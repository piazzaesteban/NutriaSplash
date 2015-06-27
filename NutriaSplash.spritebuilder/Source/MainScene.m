#import "MainScene.h"

@implementation MainScene{
    CCButton* _playButton;
    
}

-(void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    _playButton.enabled = false;
}

@end
