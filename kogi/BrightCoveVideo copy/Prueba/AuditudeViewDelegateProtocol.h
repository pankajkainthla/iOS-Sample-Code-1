//
//  AuditudeViewDelegate.h
//  AuditudeAdAPI
//
//  Created by Venkat on 5/18/10.
//  Copyright 2010 Auditude. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AuditudeViewDelegate <NSObject>

@required


@optional


#pragma mark -
#pragma mark Ad Properties

/**
 @brief The timeout for the adserver call to fetch ads
 
 Specifies the timeout used to fetch the adserver call. If the call does not return within the timeout,
 the app is notifed of init complete immediately.
 */
- (NSTimeInterval) requestTimeout;

/**
 @brief Specifies whether or not mid-roll breaks are managed by Auditude
 
 If this function returns false, the app must handle all mid-roll breaks. It is useful when the app
 wants to control when the mid-roll breaks should happen. The app has to explicitly call beginBreak
 to start a mid-roll break.
 
 Default is false
 */
- (BOOL) shouldAuditudeManageBreaks;

/**
 @brief Specifies if an upcoming break should be skipped or not
 
 When the Auditude plug-in is managing breaks, this function is called to let the app decide whether or not
 an upcoming break should be skipped. If it returns false, the break will be skipped. Note that this function
 will be called several times during content playback and hence the app should have minimal logic inside this call.
 
 Default behavior is false
 */
- (BOOL) shouldAuditudeSkipUpcomingBreak;


#pragma mark -
#pragma mark Auditude Callbacks

/**
 @brief Ads have been requested and the library is initialized
 
 This message is sent after the application requested ads and the ads have been fetched from the
 auditude server and initialized. The application can start playing the video after this event
 or request a break through the AuditudeView instance.
*/
- (void) auditudeInitComplete:(NSDictionary *)data;

/**
 @brief The break started to play with linear ads
 
 This message is sent after the application calls breakBegin on the AuditudeView instance. If there are no
 ads to play in the current break, the library invokes auditudeBreakEnd immediately.
 */
- (void) auditudeBreakBegin:(NSDictionary *)data;

/**
 @brief The current break finished playing
 
 This message is sent when the library finished playing all ads within the current break.
 Application should start or resume the main video after this message is received. Applications
 that wish to show pre-roll and mid-roll ads should use this call to play the main video.
 */
- (void) auditudeBreakEnd:(NSDictionary *)data;

/**
 @brief The linear ad started playing
 
 Notifies the application that a linear ad started playing.
 */
- (void) auditudeLinearAdBegin:(NSDictionary *)data;

/**
 @brief The linear ad finished playing
 
 Notifies the application that a linear ad completed playing. The application should wait for
 auitudeBreakEnd call to start or resume the main video.
 */
- (void) auditudeLinearAdEnd:(NSDictionary *)data;

/**
 @brief The playback progress notification for the current ad
 
 Notifies the application about the playback progress of the current linear ad.
 */
- (void) auditudeLinearAdProgress:(NSTimeInterval)currentPlaybackTime totalTime:(NSTimeInterval)totalTime;

/**
 @brief The ad has been clicked
 
 Notifies the application that an ad has been clicked
 */
- (void) auditudeAdClickThrough:(NSString *)url;

/**
 @brief The current video should be paused for a linear ad
 
 When the application receives this call, it should pause the main video and get ready
 for an ad to start playing.
 */
- (void) auditudePausePlayback;

/**
 @brief The current video should resume playback
 
 When the application receives this call, it should resume playing the main video
 */
- (void) auditudeResumePlayback;

@end
