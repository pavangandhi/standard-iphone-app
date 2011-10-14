//
//  standard_iphone_appAppDelegate.m
//  standard-iphone-app
//
//  Created by Alexander Herbel on 17.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "standard_iphone_appDelegate.h"
#import "DCIntrospect.h"
#import "TBLCategories.h"

@implementation standard_iphone_appDelegate
@synthesize window=_window;

@synthesize tabbarController;

-(DBConnection*) getCurrentDBConnection {
    return dbConnection;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self loadDatabase];
	[self loadSplashView];
	[self loadInspector];
	[self loadAppSettings];
	
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(onSlashScreenExpired) userInfo:nil repeats:NO];	

    return YES;
}

-(void) loadDatabase {
	// Erstelle eine SQLite Datenbank
    dbConnection = [DBConnection new];
}

-(void) loadSplashView {
    splashView = [SplashView new];
    [self.window addSubview:splashView.view];
    [self.window makeKeyAndVisible];	
}

-(void) loadInspector {
	
	// create a custom tap gesture recognizer so introspection can be invoked from a device
	// this one is a three finger double tap
	UITapGestureRecognizer *defaultGestureRecognizer = [[[UITapGestureRecognizer alloc] init] autorelease];
	defaultGestureRecognizer.cancelsTouchesInView = NO;
	defaultGestureRecognizer.delaysTouchesBegan = NO;
	defaultGestureRecognizer.delaysTouchesEnded = NO;
	defaultGestureRecognizer.numberOfTapsRequired = 3;
	defaultGestureRecognizer.numberOfTouchesRequired = 2;
	[DCIntrospect sharedIntrospector].invokeGestureRecognizer = defaultGestureRecognizer;    
	
	// always insert this AFTER makeKeyAndVisible so statusBarOrientation is reported correctly.
	[[DCIntrospect sharedIntrospector] start];
}


-(void) loadAppSettings {
	
	NSInteger latestVersionID = [[AppSettingsManager sharedManager] getVersionNumberBeforeUpdate];
	
	// 10001 => 1.00.01
	[[AppSettingsManager sharedManager] setVersionNumber:10002];
	
	// Set if App is a full version
	[[AppSettingsManager sharedManager] setIsProVersion:YES];
	
	// Check if apps starts the first time
	if([[AppSettingsManager sharedManager] isFirstStart] == TRUE) {
		NSLog(@" FIRST START ");
		
		// Load default settings
		[[AppSettingsManager sharedManager] setDefaultNavigationControllerTintColor:[UIColor greenColor]];
		[[AppSettingsManager sharedManager] setDefaultViewBackgroundColor:[UIColor yellowColor]];
		[[AppSettingsManager sharedManager] setIsOrientationEnabled:NO];
	}
	
	// Check if start is an update
	if([[AppSettingsManager sharedManager] isUpdate] == TRUE) {
		
		if(latestVersionID == 10001) {
			NSLog(@"UDATE FROM 10001 TO 10002");
		}
		else if(latestVersionID == 10002) {
			NSLog(@"UDATE FROM 10002 TO 10003");
		}
		else if(latestVersionID == 10003) {
			NSLog(@"UDATE FROM 10003 TO 10004");
		}				
		else if(latestVersionID == 10004) {
			NSLog(@"UDATE FROM 10004 TO 10005");
		}
	}		
}


-(void) onSlashScreenExpired {
    [splashView.view removeFromSuperview];
    
    CategoriesView *categoriesView = [CategoriesView new];
    UINavigationController *ncCategoriesView = [[UINavigationController alloc] initWithRootViewController:categoriesView];
    ncCategoriesView.title = @"Test1";
    
    CategoriesView *categoriesView2 = [CategoriesView new];
    UINavigationController *ncCategoriesView2 = [[UINavigationController alloc] initWithRootViewController:categoriesView2];
    ncCategoriesView2.title = @"Test2"; 
    
    self.tabbarController = [[UITabBarController alloc] init];
    self.tabbarController.viewControllers = [NSArray arrayWithObjects:ncCategoriesView,ncCategoriesView2,nil];
    [self.window addSubview:[self.tabbarController view]];
    
    [ncCategoriesView release];
    [ncCategoriesView2 release];
    [categoriesView2 release];
    [categoriesView release];
    
}


- (void)dealloc
{
    [_window release];
    [tabbarController release];
    [super dealloc];
}

@end