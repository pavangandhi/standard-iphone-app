//
//  AllRecordsView.m
//  weltrekorde
//
//  Created by Alexander Herbel on 08.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoriesView.h"
#import "AppInformation.h"
#import "Currency.h"


@implementation CategoriesView

-(void) loadView {
	
	
    [super loadView];
    [self createTable];
    self.title = @"Test";
	
    float zahl = 12.5;
    NSLog(@"%@",[Currency stringFromFloat:zahl]);
    
    NSString *zahl2 = @"12.50";
    NSLog(@"%f",[Currency floatFromString:zahl2]);
    
    
	NSLog(@"%@",LANG(@"Willkommen zu Hause",nil));
	
	NSLog(@"App Displayname: %@",[AppInformation getAppName]);
	NSLog(@"App Identifier: %@",[AppInformation getAppIdentifier]);
	NSLog(@"App Version: %@",[AppInformation getCurrentAppVersion]);
	NSLog(@"Build Version: %@",[AppInformation getBuildVersion]);
	NSLog(@"Current Language: %@",[AppInformation getCurrentLocale]);
	NSLog(@"Device Identifier: %@",[AppInformation deviceIdentifer]);
	NSLog(@"Device Plattform: %@",[AppInformation getHardwareDevice]);
	NSLog(@"Device Type: %@", [AppInformation getPlatformType]);
	NSLog(@"System Version: %@",[AppInformation getSystemVersion]);
}

-(void) createTable {
    tbl_categories = [[ComplexTableView alloc] initWithStyle:UITableViewStyleGrouped andNavi:YES Toolbar:YES CustomSearcbar:NO];
    tbl_categories.functionDelegate = self;
    
    ComplexTableSection *sec1 = [tbl_categories createSection:@"sec1" andTitel:@""];
    [sec1 addCell:@"menschen" andTitel:@"Test1" andCellType:UITableViewCellStyleValue1]; 
    [sec1 addCell:@"test" andTitel:@"Test2" andCellType:UITableViewCellStyleValue1]; 
    ComplexTableCell *alerviewcell = [sec1 addCell:@"computer" andTitel:@"delete" andCellType:UITableViewCellStyleValue1]; 
    alerviewcell.didSelectSelector = @selector(showAlertView);
    
    ComplexTableCell *cell=  [sec1 addCell:@"ActionSheet" andTitel:@"resave" andCellType:UITableViewCellStyleValue1];  
    cell.didSelectSelector = @selector(showActionSheet);
    
    
    AsyncUIImage *image = [[AsyncUIImage alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    [image loadImageFromURL:@"http://www.ste.ag/wp-content/uploads/2007/07/canon-eos-5d-markii.jpg"];
    [cell.contentView addSubview:image];
    
    [self.view addSubview:tbl_categories];
    [tbl_categories release];
    [image release];
}


-(void) showActionSheet {
	TBLCategories *cat = [TBLCategories findFirstByCriteria:@"WHERE 1"];
	NSLog(@"1: %@",cat.categorieName);
	NSLog(@"2: %lld",cat.pk);
	NSLog(@"3: %@",cat.updatedAt);
	NSLog(@"4: %@",cat.createdAt);
	NSLog(@"5: %i",cat.anzahl);
	NSLog(@"6: %@",cat.asdf);
	NSLog(@"7: %@",cat.kaufdatum);
	NSLog(@"8: %f",cat.preis);
	
	cat.preis = 1999.99;
	
	[cat save];
	
}


-(void) showAlertView {
 	TBLCategories *cat = [TBLCategories findFirstByQuery:@"SELECT * FROM TBLCategories WHERE 1"];
	[cat delete];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
