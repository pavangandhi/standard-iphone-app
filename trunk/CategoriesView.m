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
    [sec1 addCell:@"medien" andTitel:@"Test4" andCellType:UITableViewCellStyleValue1];  
    [self.view addSubview:tbl_categories];
}


- (void)viewDidLoad
{
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame: [[UIScreen mainScreen] applicationFrame]];  
    webView.delegate = self;  

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.3lang.de/test.mp3"] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];  
    [webView loadRequest: request]; 
//    [self.view addSubview:webView];

    
    
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
