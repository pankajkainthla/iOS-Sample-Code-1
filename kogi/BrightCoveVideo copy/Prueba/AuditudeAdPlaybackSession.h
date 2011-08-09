//
//  AuditudeAdPlaybackSession.h
//  AuditudeAdAPI
//
//  Created by Venkat on 7/11/11.
//  Copyright 2011 Auditude. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AuditudeAdPlaybackSession : NSObject {

}

- (void)notifyPause;
- (void)notifyPlay;
- (void)notifyStop;

@end
