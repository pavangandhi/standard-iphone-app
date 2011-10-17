//
//  TBLCategories.m
//  weltrekorde
//
//  Created by Alexander Herbel on 31.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TBLCategories.h"


@implementation TBLCategories
@synthesize categorieName;
@synthesize asdf;
@synthesize anzahl;
@synthesize kaufdatum;
@synthesize preis;

+(NSArray *)indices {
    NSArray *one = [NSArray arrayWithObjects:@"categorieName", nil];
    NSArray *two = [NSArray arrayWithObjects:@"asdf", nil];
    return [NSArray arrayWithObjects:one,two, nil];
}

@end
