//
//  AppSettings.h
//  standard-iphone-app
//
//  Created by Alexander on 14.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppSettingsManager : NSObject {
	BOOL _isUpdate;
	BOOL _isFirstStart;
	BOOL _isPROVersion;
}


// Singleton Getter
+ (AppSettingsManager *)sharedManager;

-(NSMutableArray*) getVersionsList;
-(NSInteger) getVersionNumberBeforeUpdate; 
-(NSString*) getStringVersionNumber;
-(NSInteger) getIntegerVersionNumber;
-(BOOL) isUpdate;
-(BOOL) isFirstStart;
-(BOOL) setVersionNumber:(NSString*) version_number;
-(BOOL) setDefaultViewBackgroundColor:(UIColor*)color;
-(UIColor*) getDefaultViewBackgroundColor;
-(BOOL) setIsOrientationEnabled:(BOOL)yesNo;
-(BOOL) isOrientationEnabled;
-(BOOL) setDefaultNavigationControllerTintColor:(UIColor*)color;
-(UIColor*) getDefaultNavigationControllerTintColor;
-(void) setIsProVersion:(BOOL) yesNo;
-(BOOL) isPROVersion;

@end
