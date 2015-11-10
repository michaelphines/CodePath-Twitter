//
//  User.h
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)user;
+ (void)logout;

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *handle;
@property (nonatomic, strong) NSURL *profileImageURL;
@property (nonatomic, strong) NSString *tagline;

@end
