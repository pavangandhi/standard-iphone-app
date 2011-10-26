//
//  AppLanguageClass.m
//  standard-iphone-app
//
//  Created by Per Hlawatschek on 26.10.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppLanguageClass.h"
#import "UserDefaults.h"


#define APP_LANGUAGE_PREFIX @"_app_language_prefix"

@implementation AppLanguageClass

static NSBundle *bundle = nil;


+(NSArray*) getSupportedAppLanguagesPrefixes {
    return [NSArray arrayWithObjects:@"en","de", nil];
}


+(NSArray*) getSupportedAppLanguages {
    return [NSArray arrayWithObjects: LANG(@"Englisch", nil), LANG(@"Deutsch", nil), nil];
}

+(NSString*) getDefaultAppLanguagePrefix {
    return @"en";
}


/* ------------------------------------------------- */
/* ------------------------------------------------- */
/* ------------------------------------------------- */


+(void) setupLanguageForFirstStart {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray *appleLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentiPhoneLanguage = [appleLanguages objectAtIndex:0];
    
    if([[self getSupportedAppLanguages] containsObject:currentiPhoneLanguage]) {
        [self changeLanguageTo:currentiPhoneLanguage];
    } else {
        [self changeLanguageTo:[self getDefaultAppLanguagePrefix]];    
    }
}


+(void) initialize {
    NSString *currentiPhoneLanguage = [self getAppLanguagePrefix];
    NSString *path = [[NSBundle mainBundle] pathForResource:currentiPhoneLanguage ofType:@"lproj"];
    bundle = [[NSBundle alloc] initWithPath:path];
}


+(void)changeLanguageTo:(NSString *)language {
    [self setAppLanguagePrefix:language];
}


+(NSString *)get:(NSString *)key alter:(NSString *)alternate {
    return [bundle localizedStringForKey:key value:alternate table:nil];
}


+(BOOL) setAppLanguagePrefix:(NSString*)langPrefix {
	return [UserDefaults setString:langPrefix forKey:APP_LANGUAGE_PREFIX];
}

+(NSString*) getAppLanguagePrefix {
	return [UserDefaults getStringForKey:APP_LANGUAGE_PREFIX];
}


@end
