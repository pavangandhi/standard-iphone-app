//
//  AppSettings.m
//  standard-iphone-app
//
//  Created by Alexander on 14.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppSettingsManager.h"
#import "UserDefaults.h"

#define IS_APP_ORIENTATION_ENABLE @"_isAppOrientationEnabled"
#define DEFAULT_VIEW_BACKGROUND_COLOR @"_defaultViewBackgroundColor"
#define DEFAULT_NAVIGATION_CONTROLLER_TINT_COLOR @"_defaultNavigationControllerTintColor"
#define APP_VERSIONS_LIST @"_app_versions_list"
#define APP_VERSION_NUMBER @"_app_version_number"

@implementation AppSettingsManager

/**
 * Creates a singleton instance
 *
 * @return AppSettingsManger instance
 */

+ (AppSettingsManager *)sharedManager {
	static AppSettingsManager *settingsManager = nil;
	
	if (settingsManager == nil) {
		settingsManager = [[AppSettingsManager alloc] init];
	}
	
	return settingsManager;
}


-(void) setIsProVersion:(BOOL) yesNo {
	_isPROVersion = yesNo;
}

-(BOOL) isPROVersion {
	return _isPROVersion;
}

/**
 * Returns the current app version number
 *
 * @return integer
 */


-(NSInteger) getVersionNumber {
	return [UserDefaults getIntegerForKey:APP_VERSION_NUMBER];
}



/**
 * Set the a version number and checks if the version is an update
 *
 * @return AppSettingsManger instance
 */


-(BOOL) setVersionNumber:(NSInteger) version_number {

	NSNumber *versionNumber = [NSNumber numberWithInt:version_number];
	NSMutableArray *versionsList = [self getVersionsList];
	
	if(versionsList == nil) {
		versionsList = [NSArray arrayWithObject:versionNumber];
		_isFirstStart = TRUE;
	} else {
		if(![versionsList containsObject:versionNumber]) {
			_isUpdate = TRUE;
			[versionsList addObject:versionNumber];
		}
	}
	[UserDefaults setArray:versionsList forKey:APP_VERSIONS_LIST];
	return [UserDefaults setInteger:version_number forKey:APP_VERSION_NUMBER];
}	 


-(NSMutableArray*) getVersionsList {
	return [UserDefaults getArrayForKey:APP_VERSIONS_LIST];
}

-(BOOL) isFirstStart {
	return _isFirstStart;
}

-(BOOL) isUpdate {
	return _isUpdate;
}

-(NSInteger) getVersionNumberBeforeUpdate {
	NSMutableArray *versionList = [self getVersionsList];
	
	int maxValue = 0;
	for (NSNumber *version in versionList)
	{
		int currentValue = [version intValue];
		if (currentValue > maxValue)
			maxValue = currentValue;
	}
	return maxValue;
}



/**
 * Default View Background Color
 * 
 * @return BOOL
 */

-(BOOL) setDefaultViewBackgroundColor:(UIColor*)color {
	return [UserDefaults setColor:color forKey:DEFAULT_VIEW_BACKGROUND_COLOR];
}

-(UIColor*) getDefaultViewBackgroundColor {
	return [UserDefaults getColorForKey:DEFAULT_VIEW_BACKGROUND_COLOR];
}





/**
 * is orientation enabled
 * 
 * @return BOOL
 */

-(BOOL) setIsOrientationEnabled:(BOOL)yesNo {
	return [UserDefaults setBool:yesNo forKey:IS_APP_ORIENTATION_ENABLE];
}

-(BOOL) isOrientationEnabled {
	return [UserDefaults getBoolForKey:IS_APP_ORIENTATION_ENABLE];
}




/**
 * Default Navigation Controller Tint Color
 * 
 * @return BOOL
 */

-(BOOL) setDefaultNavigationControllerTintColor:(UIColor*)color {
	return [UserDefaults setColor:color forKey:DEFAULT_NAVIGATION_CONTROLLER_TINT_COLOR];
}

-(UIColor*) getDefaultNavigationControllerTintColor {
	return [UserDefaults getColorForKey:DEFAULT_NAVIGATION_CONTROLLER_TINT_COLOR];
}





@end
