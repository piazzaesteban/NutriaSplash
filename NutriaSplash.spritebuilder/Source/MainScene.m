#import "MainScene.h"

@implementation MainScene{
    CCButton* _playButton;
    
}

-(void)didLoadFromCCB{
    [[OALSimpleAudio sharedInstance] playBgWithLoop:TRUE];
}

-(void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"LevelSelection"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    _playButton.enabled = false;
}

@end
