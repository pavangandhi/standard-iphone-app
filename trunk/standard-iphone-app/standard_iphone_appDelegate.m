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
	
    // Erstelle eine SQLite Datenbank
    dbConnection = [DBConnection new];
    
    splashView = [SplashView new];
    [self.window addSubview:splashView.view];
    [self.window makeKeyAndVisible];

	/**
	 * 
	 * INSPECTOR
	 */
	
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
	
	
	
    //set delay before showing new screen
    // Perform a function when done with loading
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(onSlashScreenExpired) userInfo:nil repeats:NO];
    
    return YES;
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