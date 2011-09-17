//
//  UserDefaults.m
//  RedCarper
//
//  Created by Alexander Herbel on 07.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UserDefaults.h"


@implementation UserDefaults


#pragma mark - NSUserDefaults -> getStandardUserDefaults

// Function: return the NSUserDefaults Standard UserDefaults
// Return: standardUserDefaults
 
+(NSUserDefaults*) getStandardUserDefaults {
    return [NSUserDefaults standardUserDefaults];
}


 
#pragma mark - NSUserDefaults -> String

// Function: Function to get a string from UserDefaults for a custom key
// Return: string
 
+(NSString*) getStringForKey:(NSString*)key {
    return [[self getStandardUserDefaults] stringForKey:key];
}

// Function: Function to set a string to UserDefaults for a custom key
// Return: boolean value if synchronize was successful or not (yes => successful, no => not successful)
 
+(BOOL) setString:(NSString*)value forKey:(NSString*)key {
    [[self getStandardUserDefaults] setObject:value forKey:key];
    return [[self getStandardUserDefaults] synchronize];
}



#pragma mark - NSUserDefaults -> Float

// Function: Function to get a float value from UserDefaults for a custom key
// Return: float

+(float) getFloatForKey:(NSString*)key {
    return [[self getStandardUserDefaults] floatForKey:key];
}

// Function: Function to set a float value to UserDefaults for a custom key
// Return: boolean value if synchronize was successful or not (yes => successful, no => not successful)

+(BOOL) setFloat:(float)value forKey:(NSString*)key {
    [[self getStandardUserDefaults] setFloat:value forKey:key];
    return [[self getStandardUserDefaults] synchronize];

}



#pragma mark - NSUserDefaults -> Integer

// Function: Function to get an integer value from UserDefaults for a custom key
// Return: string

+(int) getIntegerForKey:(NSString*)key {
    return [[self getStandardUserDefaults] integerForKey:key];
}

// Function: Function to set an integer value to UserDefaults for a custom key
// Return: boolean value if synchronize was successful or not (yes => successful, no => not successful)

+(BOOL) setInteger:(int)value forKey:(NSString*)key {
    [[self getStandardUserDefaults] setInteger:value forKey:key];
    return [[self getStandardUserDefaults] synchronize];
}


#pragma mark - NSUserDefaults -> Bool

 
// Function: Function to get a boolean value to UserDefaults for a custom key
// Return: boolean value
 
+(BOOL) getBoolForKey:(NSString*)key {
    return [[self getStandardUserDefaults] boolForKey:key];
}

 
// Function: Function to set a string from UserDefaults for a custom key
// Return: boolean value if synchronize was successful or not

+(BOOL) setBool:(BOOL)yesNo forKey:(NSString*)key {
    [[self getStandardUserDefaults] setBool:yesNo forKey:key ];
    return [[self getStandardUserDefaults] synchronize];
}


#pragma mark - NSUserDefaults -> UIColor


// Function: Function to get a color value from UserDefaults for a custom key
// Return: uicolor value

+(UIColor*) getColorForKey:(NSString*)key {
    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
}

// Function: Function to set a uicolor to UserDefaults for a custom key
// Return: boolean value if synchronize was successful or not

+(BOOL) setColor:(UIColor*)color forKey:(NSString*)key {
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:color];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:key];
    return [[self getStandardUserDefaults] synchronize];
}



// STANDARD DEFAULT SETTINGS !!!

+(void) setDefaultSettings {
    [UserDefaults setBool:YES forKey:isAppOrientationEnabled];
    [UserDefaults setColor:[UIColor getStandardBackgroundColor] forKey:standardBackgroundColor];
}



@end
