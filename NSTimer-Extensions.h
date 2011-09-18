//
//  NSTimer-Extensions.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSTimer (NSTimer_Extensions)

/*
[NSTimer scheduledTimerWithTimeInterval:2.0 block:^{
    int x = 0;
    x++;
    [someObj test:x];
} repeats:NO];
*/

+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;
+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

@end
