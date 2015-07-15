
#import "MainScene.h"

@implementation MainScene{
    CCButton* _playButton;
    
}

<<<<<<< HEAD
-(void)didLoadFromCCB{
    [[OALSimpleAudio sharedInstance] playBgWithLoop:TRUE];
=======
-(id)init{
    if (self = [super init]) {
    }
    return self;
>>>>>>> 5059237ae7352de4bf11667a85b72cbaadc2e148
}

-(void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"LevelSelection"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    _playButton.enabled = false;
}

@end
