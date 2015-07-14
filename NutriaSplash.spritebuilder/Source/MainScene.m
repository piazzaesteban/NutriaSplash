
#import "MainScene.h"

@implementation MainScene{
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
