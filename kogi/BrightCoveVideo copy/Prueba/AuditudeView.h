//
//  AuditudeView.h
//  AuditudeAdAPI
//
//  Created by Venkat on 5/17/10.
//  Copyright 2010 Auditude. All rights reserved.
//


/**
 @mainpage Auditude Advertising API
 
 The Auditude Advertising API is a Cocoa/Objective-C Library for rendering video and companion banners
 ads on iOS 4.0 or above.
*/


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AuditudeViewDelegateProtocol.h"

extern NSString *PlayheadTimeInSeconds;
extern NSString *TotalTimeInSeconds;


@interface AuditudeView : UIView
{
	id<AuditudeViewDelegate> _delegate;
}

/**
 @brief The enumeration of various video playback status notifications
 */
typedef enum
{
	AuditudeNotificationTypeVideoPlaybackStarted = 0,
	AuditudeNotificationTypeVideoPlaybackPaused,
	AuditudeNotificationTypeVideoPlaybackResumed,
	AuditudeNotificationTypeVideoPlaybackComplete,
	AuditudeNotificationTypeVideoPlayheadUpdate,
	AuditudeNotificationTypeVideoSeek
} AuditudeNotificationType;

/**
 @brief The AuditudeViewDelegate instance required by the library to notify ad playback messages.
 */
@property (nonatomic, assign) id<AuditudeViewDelegate> delegate;


#pragma mark -
#pragma mark AuditudeView Class Functions

/**
 Returns the current version of the Auditude Ad SDK
 */
+ (NSString *)auditudeSDKVersion;

/**
 Toggles debug logging from the Auditude SDK on or off.
 Default is YES.
 */
+ (void)enableDebugLog:(BOOL)enable;


#pragma mark -
#pragma mark Ad Request Functions

/**
 @brief Request ads for a video
 
 Request ads for a video with an id, domain and publisher zone id.
 */
- (void)requestAdsForVideo:(NSString *)videoId
					zoneId:(NSInteger)publisherZoneId
					domain:(NSString *)auditudeDomain;

/**
 @brief Request ads for a video with custom params (key-values)

  Request ads for a video with an id, domain, publisher zone id and key-value pairs.
 */
- (void)requestAdsForVideo:(NSString *)videoId
					zoneId:(NSInteger)publisherZoneId
					domain:(NSString *)auditudeDomain
		   targetingParams:(NSDictionary *)targetingParams;


#pragma mark -
#pragma mark Ad Break Control Functions

/**
 @brief Notify the library to start playing ads from the next break
 
 This method should be called only after the auditudeInitComplete delegate function is invoked.
 Applications wishing to show a pre-roll ad should call this before the main video starts playing.
 */
- (void)beginBreak;

/**
 @brief Notify the library to stop ad playback
 
 The library is informed to stopped all linear ad playback and end the break.
 This forces the library to call auditudeBreakEnd if it is currently handling a break.
 */
- (void)endBreak;

/**
 Poll the library of the current break play status. This will return YES if the library
 is currently in a break and NO otherwise.
 */
- (BOOL)isHandlingBreak;


#pragma mark -
#pragma mark Content Playback Notifications

/**
 @brief Notify the library about current video playback status
 
 This method should be called to inform the library about current video playback status.
 It should be called when the main video started and completed playback. It should also
 be called when the main video is paused or resumed.
 */
- (void)notify:(AuditudeNotificationType)type notificationParams:(NSDictionary *)params;


@end
