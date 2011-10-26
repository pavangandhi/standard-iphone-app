//
//  ListSelectionArrayType.m
//  RedCarper
//
//  Created by Alexander Herbel on 19.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectionType.h"


@implementation SelectionType

@synthesize s_labelText;
@synthesize s_detailText;
@synthesize s_returnValue;
@synthesize i_returnValue;
@synthesize ui_image;


-(void) dealloc {
    CLEAR_OBJ(s_labelText);
    CLEAR_OBJ(s_detailText);
    CLEAR_OBJ(s_returnValue);
    CLEAR_OBJ(ui_image)
    [super dealloc];
}

@end
