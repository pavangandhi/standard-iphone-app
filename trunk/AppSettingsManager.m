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

static AppSettingsManager *settingsManager = nil;

+ (AppSettingsManager *)sharedManager {

	if (settingsManager == nil) {
		settingsManager = [[super allocWithZone:NULL] init];
	}
		
	return settingsManager;
}


+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedManager] retain];
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////// SINGLETON END /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


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


-(NSString*) getStringVersionNumber {
	return [UserDefaults getStringForKey:APP_VERSION_NUMBER];
}

-(NSInteger) getIntegerVersionNumber {
	NSString *s_version = [self getStringVersionNumber];
	s_version = [s_version stringByReplacingOccurrencesOfString:@"." withString:@""];
	return [s_version intValue];
}


/**
 * Set the a version number and checks if the version is an update
 *
 * @return AppSettingsManger instance
 */


-(BOOL) setVersionNumber:(NSString*) version_number {

	NSMutableArray *versionsList = [self getVersionsList];
	
	if(versionsList == nil) {
		versionsList = [NSArray arrayWithObject:version_number];
		_isFirstStart = TRUE;
	} else {
		if(![versionsList containsObject:version_number]) {
			_isUpdate = TRUE;
			[versionsList addObject:version_number];
		}
	}
	[UserDefaults setArray:versionsList forKey:APP_VERSIONS_LIST];
	return [UserDefaults setString:version_number forKey:APP_VERSION_NUMBER];
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
	for (NSString *version in versionList)
	{
		version = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
		
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
