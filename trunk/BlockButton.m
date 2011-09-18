//
//  BlockButton.m
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BlockButton.h"


@implementation BlockButton

@synthesize label;
@synthesize action;

-(id)initWithLabel:(NSString*) string
{
    if ((self = [super init])) {
        label = string;
    }
    return self;
}


-(void)dealloc
{
    [action release];
    action = nil;
    [label release];
    label = nil;
    [super dealloc];
}

@end
