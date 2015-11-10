//
//  Tweet.m
//  TwitterApp
//
//  Created by Michael Hines on 11/9/15.
//  Copyright © 2015 Michael Hines. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.tweetId = dictionary[@"id"];
        self.text = dictionary[@"text"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        
        self.createdAt = [formatter dateFromString:createdAtString];
    }
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array)
    {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}
@end
