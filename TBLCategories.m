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
@synthesize createdAt;
@synthesize asdf;

+(NSArray *)indices {
    NSArray *one = [NSArray arrayWithObjects:@"categorieName",@"createdAt", nil];
    NSArray *two = [NSArray arrayWithObjects:@"createdAt",@"asdf", nil];
    return [NSArray arrayWithObjects:one,two, nil];
}

@end
