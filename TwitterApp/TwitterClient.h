//
//  TwitterClient.h
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import <BDBOAuth1RequestOperationManager.h>
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;
- (void)loginWithCompletion:(void (^)(User *user, NSError* error))completion;
- (void)openURL:(NSURL *)url;
- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)postTweet:(NSString *)tweetText parent:(Tweet *)parentTweet completion:(void (^)(NSError *error))completion;
- (void)retweet:(Tweet *)tweet;
- (void)favorite:(Tweet *)tweet;

@end
