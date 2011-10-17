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



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self loadDatabase];
	[self loadSplashView];
	[self loadInspector];
	[self loadAppSettings];
	
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
	
	NSInteger versionIDBeforeUpdate = [[AppSettingsManager sharedManager] getVersionNumberBeforeUpdate];
	[[AppSettingsManager sharedManager] setVersionNumber:@"1.0.03"];
	NSInteger versionIDAfterUpdate = [[AppSettingsManager sharedManager] getIntegerVersionNumber];
	
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
	
	NSLog(@"%@",[[AppSettingsManager sharedManager] getVersionsList]);
	NSLog(@"%@",[[AppSettingsManager sharedManager] getStringVersionNumber]);
	
	// Check if start is an update
	if([[AppSettingsManager sharedManager] isUpdate] == TRUE) {
		
		if(versionIDBeforeUpdate == 1001 && versionIDAfterUpdate == 1002) {
			NSLog(@"UDATE FROM 1001 TO 1002");
		}
		else if(versionIDBeforeUpdate == 1001 && versionIDAfterUpdate == 1003) {
			NSLog(@"UDATE FROM 1001 TO 1003");
		}
		else if(versionIDBeforeUpdate == 1001 && versionIDAfterUpdate == 1004) {
			NSLog(@"UDATE FROM 1001 TO 1004");
		}				
		else if(versionIDBeforeUpdate == 1002 && versionIDAfterUpdate == 1003) {
			NSLog(@"UDATE FROM 1002 TO 1003");
		}
		else if(versionIDBeforeUpdate == 1002 && versionIDAfterUpdate == 1004) {
			NSLog(@"UDATE FROM 1002 TO 1004");
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