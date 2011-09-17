//
//  ComplexTableCell.m
//  RedCarper
//
//  Created by Alexander Herbel on 13.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComplexTableCell.h"


@implementation ComplexTableCell

@synthesize infos;
@synthesize canEditCell;
@synthesize canMoveCell;
@synthesize cellHeight;
@synthesize cellName;
@synthesize didSelectSelector;
@synthesize didDeleteSelector;
@synthesize didSelectAccessorSelector;
@synthesize didMoveSelector;
@synthesize editStyle;
@synthesize hidden;
@synthesize searchTextArray;

-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        hidden = NO;
        canEditCell = NO;
        editStyle = UITableViewCellEditingStyleNone;
        cellHeight = 50;
        searchTextArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) dealloc {
    CLEAR_OBJ(searchTextArray);
    CLEAR_OBJ(cellName);
    CLEAR_OBJ(infos);
    [super dealloc];
}

@end
