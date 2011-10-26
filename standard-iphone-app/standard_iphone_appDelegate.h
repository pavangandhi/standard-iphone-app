//
//  standard_iphone_appAppDelegate.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 17.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "CategoriesView.h"
#import "SplashView.h"
#import "AppSettingsManager.h"
#import "AppLanguageClass.h"
#import "DCIntrospect.h"
#import "Currency.h"
#import "TBLCategories.h"

@interface standard_iphone_appDelegate : NSObject <UIApplicationDelegate> {

    UITabBarController *tabbarController;
    SplashView *splashView;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabbarController;

-(void) loadDatabase;
-(void) loadSplashView;
-(void) loadInspector;
-(void) loadAppSettings;

@end
