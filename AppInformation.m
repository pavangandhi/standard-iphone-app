//
//  AppInformation.m
//  standard-iphone-app
//
//  Created by Alexander on 13.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppInformation.h"
#import "UIDevice-Attributes.h"
#import "UserDefaults.h"

@implementation AppInformation

+(NSString*) getAppName {
	NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
	return appName;
}

+(NSString*) getAppIdentifier {
	NSString *identifier = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
	return identifier;
}

+(NSString*) getCurrentAppVersion {
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	return appVersion;
}

+(NSString*) getHardwareDevice {
	return [UIDevice getHardwareDeviceName];
}

+(NSString*) getBuildVersion {
	return [UIDevice getOSVersionBuild];
}

+(NSString*) deviceIdentifer {
	return [UIDevice deviceIdentifier];
}

+(NSString*) getSystemVersion {
	return [[UIDevice currentDevice] systemVersion];
}

+(NSString*) getCurrentLocale {
	return [[NSLocale currentLocale] localeIdentifier];
}

+(NSString*) getPlatformType {
	return [UIDevice  platformType];
}

 
@end
