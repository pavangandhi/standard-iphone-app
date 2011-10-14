//
//  AllRecordsView.m
//  weltrekorde
//
//  Created by Alexander Herbel on 08.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoriesView.h"
#import "ActionSheet.h"
#import "AlertView.h"
#import "AppInformation.h"

@implementation CategoriesView

-(void) loadView {
    [super loadView];
    [self createTable];
    self.title = @"Test";
	
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
    ComplexTableCell *alerviewcell = [sec1 addCell:@"computer" andTitel:@"AlertView" andCellType:UITableViewCellStyleValue1]; 
    alerviewcell.didSelectSelector = @selector(showAlertView);
    
    ComplexTableCell *cell=  [sec1 addCell:@"ActionSheet" andTitel:@"" andCellType:UITableViewCellStyleValue1];  
    cell.didSelectSelector = @selector(showActionSheet);
    
    
    AsyncUIImage *image = [[AsyncUIImage alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    [image loadImageFromURL:@"http://www.ste.ag/wp-content/uploads/2007/07/canon-eos-5d-markii.jpg"];
    [cell.contentView addSubview:image];
    
    [self.view addSubview:tbl_categories];
    [tbl_categories release];
    [image release];
}


-(void) showActionSheet {
 
}


-(void) showAlertView {
 
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
