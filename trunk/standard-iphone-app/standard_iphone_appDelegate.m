//
//  standard_iphone_appAppDelegate.m
//  standard-iphone-app
//
//  Created by Alexander Herbel on 17.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "standard_iphone_appDelegate.h"


@implementation standard_iphone_appDelegate
@synthesize window=_window;

@synthesize tabbarController;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadDatabase];
	[self loadAppSettings];    
	[self loadSplashView];
	[self loadInspector];

	
	TBLCategories *test = [TBLCategories new];
	test.categorieName = @"haha";
	test.asdf = @"123";
	test.anzahl = 33;
	test.kaufdatum = [NSDate date];
	test.preis = 23.234;
	[test save];	
	
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(onSlashScreenExpired) userInfo:nil repeats:NO];	

    return YES;
}


-(void) loadDatabase {
	[[Database sharedManager] open];
	[[Database sharedManager] setDebugMode:YES];
	[[Database sharedManager] setSyncMode:YES];
}


-(void) loadAppSettings {
	
	NSInteger versionIDBeforeUpdate = [[AppSettingsManager sharedManager] getVersionNumberBeforeUpdate];
    
	[[AppSettingsManager sharedManager] setVersionNumber:@"1.0.01"];
	NSInteger versionIDAfterUpdate = [[AppSettingsManager sharedManager] getIntegerVersionNumber];
	
	// Set if App is a full version
	[[AppSettingsManager sharedManager] setIsProVersion:YES];
	
	// Check if apps starts the first time
	if([[AppSettingsManager sharedManager] isFirstStart] == TRUE) {
		NSLog(@"APP FIRST START ");
		
		// Load default settings
		[[AppSettingsManager sharedManager] setDefaultNavigationControllerTintColor:[UIColor greenColor]];
		[[AppSettingsManager sharedManager] setDefaultViewBackgroundColor:[UIColor yellowColor]];
		[[AppSettingsManager sharedManager] setIsOrientationEnabled:NO];
        
        // Get setuped Language and set it to defaults
        [AppLanguageClass setupLanguageForFirstStart];
        
        [Currency setAppCurrencyLocale:[[NSLocale currentLocale] localeIdentifier]];  
        
	}
	
    // Initialisiere Sprachdaten
    [AppLanguageClass initialize];
    
	// Check if start is an update
	if([[AppSettingsManager sharedManager] isUpdate] == TRUE) {
		if(versionIDBeforeUpdate == 1001 && versionIDAfterUpdate == 1002) {
			NSLog(@"UDATE FROM 1001 TO 1002");
		}
	}		
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
    self.window.rootViewController = self.tabbarController;
    
    [ncCategoriesView release];
    [ncCategoriesView2 release];
    [categoriesView2 release];
    [categoriesView release];
    
}


-(void)applicationDidEnterBackground:(UIApplication *)application {
    
    UIBackgroundTaskIdentifier bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{}];
    
    NSLog(@"Wait until sqlite is done and ok");
    
    sqlite3 *database = [[Database sharedManager] getSqliteDatabase];
    sqlite3_stmt *statement;
    BOOL done = FALSE;
    while (done == FALSE) {
        NSString *query = @"SELECT * FROM TBLCategories WHERE 1";
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) 
        {
            done = TRUE;
        }
    }
    
    NSLog(@"Done, go to background");
    
    
    [[UIApplication sharedApplication] endBackgroundTask:bgTask];
}


- (void)dealloc
{
    [_window release];
    [tabbarController release];
    [super dealloc];
}

@end