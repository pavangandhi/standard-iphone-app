//
//  standard_iphone_appAppDelegate.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 17.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBConnection.h"
#import "AppSettingsManager.h"
#import "CategoriesView.h"
#import "SplashView.h"

@interface standard_iphone_appDelegate : NSObject <UIApplicationDelegate> {
    DBConnection *dbConnection;
    UITabBarController *tabbarController;
    SplashView *splashView;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabbarController;

-(DBConnection*) getCurrentDBConnection;
-(void) loadDatabase;
-(void) loadSplashView;
-(void) loadInspector;
-(void) loadAppSettings;

@end
