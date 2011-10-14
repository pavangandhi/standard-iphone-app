//
//  AppInformation.h
//  standard-iphone-app
//
//  Created by Alexander on 13.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInformation : NSObject {

}

+ (NSString*) getAppName;
+ (NSString*) getAppIdentifier;
+ (NSString*) getHardwareDevice;
+ (NSString*) getBuildVersion;
+ (NSString*) deviceIdentifer;
+ (NSString*) getSystemVersion;
+ (NSString*) getCurrentAppVersion;
+ (NSString*) getCurrentLocale;
+ (NSString*) getPlatformType;


@end
