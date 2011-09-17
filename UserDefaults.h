//
//  CustomUserDefaults.h
//  RedCarper
//
//  Created by Alexander Herbel on 07.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserDefaults : NSObject {
    
}

+ (NSUserDefaults*) getStandardUserDefaults;
+ (NSString*) getStringForKey:(NSString*)key;
+ (BOOL) setString:(NSString*)value forKey:(NSString*)key;
+ (float) getFloatForKey:(NSString*)key;
+ (BOOL) setFloat:(float)value forKey:(NSString*)key;
+ (int) getIntegerForKey:(NSString*)key;
+ (BOOL) setInteger:(int)value forKey:(NSString*)key;
+ (BOOL) getBoolForKey:(NSString*)key;
+ (BOOL) setBool:(BOOL)yesNo forKey:(NSString*)key;
+ (UIColor*) getColorForKey:(NSString*)key;
+ (BOOL) setColor:(UIColor*)color forKey:(NSString*)key;
+ (void) setDefaultSettings;

@end
