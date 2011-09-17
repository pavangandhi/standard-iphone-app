//
//  SplashView.m
//  weltrekorde
//
//  Created by Alexander Herbel on 08.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SplashView.h"


@implementation SplashView

-(void) loadView {
    [super loadView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 320, 40)];
    label.textAlignment = UITextAlignmentCenter;
    label.text = @"SPLASH";
    [self.view addSubview:label];
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
