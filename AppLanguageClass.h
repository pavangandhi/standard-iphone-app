//
//  AppLanguageClass.h
//  standard-iphone-app
//
//  Created by Per Hlawatschek on 26.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


/* COMMANDLINE genstrings -s LANG -o standard-iphone-app/en.lproj/ *.m */
#define LANG(key, comment) [AppLanguageClass get:key alter:comment]

@interface AppLanguageClass : NSObject
+(void) initialize;
+(void)setupLanguageForFirstStart;
+(void)changeLanguageTo:(NSString *)language;
+(NSString *)get:(NSString *)key alter:(NSString *)alternate;
+(NSArray*) getSupportedAppLanguagesPrefixes;
+(NSArray*) getSupportedAppLanguages;

+(NSString*) getDefaultAppLanguagePrefix;

+(BOOL) setAppLanguagePrefix:(NSString*)langPrefix;
+(NSString*) getAppLanguagePrefix;

@end
