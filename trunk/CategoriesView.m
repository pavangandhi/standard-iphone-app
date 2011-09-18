//
//  AllRecordsView.m
//  weltrekorde
//
//  Created by Alexander Herbel on 08.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoriesView.h"


@implementation CategoriesView

-(void) loadView {
    [super loadView];
    [self createTable];
    self.title = @"Test";
}

-(void) createTable {
    tbl_categories = [[ComplexTableView alloc] initWithStyle:UITableViewStyleGrouped andNavi:YES Toolbar:YES CustomSearcbar:NO];
    tbl_categories.functionDelegate = self;
    
    ComplexTableSection *sec1 = [tbl_categories createSection:@"sec1" andTitel:@""];
    [sec1 addCell:@"menschen" andTitel:@"Test1" andCellType:UITableViewCellStyleValue1]; 
    [sec1 addCell:@"sex" andTitel:@"Test2" andCellType:UITableViewCellStyleValue1]; 
    [sec1 addCell:@"computer" andTitel:@"Test3" andCellType:UITableViewCellStyleValue1]; 
    ComplexTableCell *cell=  [sec1 addCell:@"medien" andTitel:@"" andCellType:UITableViewCellStyleValue1];  
    
    AsyncUIImage *image = [[AsyncUIImage alloc] initWithFrame:CGRectMake(2, 2, 40, 40)];
    [image loadImageFromURL:@"http://www.ste.ag/wp-content/uploads/2007/07/canon-eos-5d-markii.jpg"];
    [cell.contentView addSubview:image];
    
    [self.view addSubview:tbl_categories];
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
