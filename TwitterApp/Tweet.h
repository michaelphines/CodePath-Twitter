//
//  Tweet.h
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)tweetsWithArray:(NSArray *)array;

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) User *user;

@end
