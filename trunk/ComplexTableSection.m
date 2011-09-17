//
//  ComplexTableSection.m
//  RedCarper
//
//  Created by Alexander Herbel on 13.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComplexTableSection.h"


@implementation ComplexTableSection

@synthesize showWhenNoRows;
@synthesize sectionName;
@synthesize titleHeader;
@synthesize headerView;
@synthesize footerView;
@synthesize allCells;
@synthesize currentCells;
@synthesize titleFooter;
@synthesize hidden;
@synthesize titleHeaderWhenNoRows;
@synthesize titleFooterWhenNoRows;

/*  
 ----------------------------------------------------------------------- 
 - init method
 
*/

-(id)init
{
    if ((self = [super init]))
    {
        if(allCells == nil) {
            allCells = [[NSMutableArray alloc] init];
            currentCells = [[NSMutableArray alloc] init];
        }
    }
    return self;
}




/*  
 ----------------------------------------------------------------------- 
 - method to add a cell to the section
 
*/


-(ComplexTableCell*) addCell:(NSString*) cellName andTitel:(NSString*) titetText andCellType:(UITableViewCellStyle) style {
    
    ComplexTableCell *cell = [[ComplexTableCell alloc] initWithStyle:style reuseIdentifier:@"custom"];
    cell.cellName = cellName;
    cell.textLabel.text = titetText;
    cell.cellHeight = 44;
    [allCells addObject:cell];
    [currentCells addObject:cell];
    
    [cell release];
    return cell;
}




-(ComplexTableCell*) insertCell:(NSString*) cellName andTitel:(NSString*) titetText andCellType:(UITableViewCellStyle) style AtIndex:(int) index {
    
    ComplexTableCell *cell = [[ComplexTableCell alloc] initWithStyle:style reuseIdentifier:@"custom"];
    cell.cellName = cellName;
    cell.textLabel.text = titetText;
    
    [allCells insertObject:cell atIndex:index];
    [self rebuildCurrentCells];
    
    [cell release];
    return cell;
}



-(void) addComplexCell:(ComplexTableCell*)cell {
    [allCells addObject:cell];
    
    if(cell.hidden == NO) {
        [currentCells addObject:cell];
    }
}


-(void) addComplexCell:(ComplexTableCell*)cell AtIndex:(int) index {
    [allCells insertObject:cell atIndex:index];
    [self rebuildCurrentCells];      
}



/*  
 ----------------------------------------------------------------------- 
 - method to get number of cells in section
 
*/

-(int) getNumberOfVisibleCells {
    return [currentCells count];    
}

-(int) getNumberOfAllCells {
    return [allCells count];    
}






/*  
 ----------------------------------------------------------------------- 
 - method to get a cell 
 
*/


-(ComplexTableCell*) getCellAtIndex:(int) index {
    ComplexTableCell *cell = [currentCells objectAtIndex:index];    
    return cell;
}


-(ComplexTableCell*) getCellWithCellName:(NSString*)cellName {
    ComplexTableCell *cell = nil;
    int numberOfAllCells = [allCells count];
    for(int x = 0;x < numberOfAllCells;x++) {
        cell = [allCells objectAtIndex:x];
        if([cell.cellName isEqualToString:cellName]) {
            return cell;
        }
    }
    return nil;
}




/*  
  ----------------------------------------------------------------------- 
  - method to remove cells 
    
*/


-(void) checkSectionForVisibility {
    if([self getNumberOfVisibleCells]==0 && showWhenNoRows == NO) {
        hidden = YES;
    }
}


-(void) removeCell:(ComplexTableCell*) cell {
    [currentCells removeObject:cell];
    [allCells removeObject:cell];
    [self checkSectionForVisibility];
}

-(void) removeCellAtIndex:(int) index {
    ComplexTableCell *cell = [self getCellAtIndex:index];
    [currentCells removeObject:cell];
    [allCells removeObject:cell];
    [self checkSectionForVisibility];
}



-(void) removeCellWithName:(NSString*)cellName {
    ComplexTableCell *cell = [self getCellWithCellName:cellName];
    [currentCells removeObject:cell];
    [allCells removeObject:cell];
    [self checkSectionForVisibility];
}



/*  
  ----------------------------------------------------------------------- 
  - Hide cells method  
  - relates to currentCells
 
*/


-(void) hideCell:(BOOL) yesNo withCellName:(NSString*) cellName {
    ComplexTableCell *cell = [self getCellWithCellName:cellName];
    cell.hidden = yesNo;
    
    if(yesNo == YES) {
        [currentCells removeObject:cell];
        [self checkSectionForVisibility];
    } else {
        [self rebuildCurrentCells];
    }
}



-(void) hideCell:(BOOL) yesNo atIndex:(int) index {
    ComplexTableCell *cell = [self getCellAtIndex:index];
    cell.hidden = yesNo;
    
    if(yesNo == YES) {
        [currentCells removeObject:cell];
        [self checkSectionForVisibility];
    } else {
        [self rebuildCurrentCells];
    }
}




/*  
 ----------------------------------------------------------------------- 
 - Hide cells method  
 - Relates to allCells
 
*/


-(void) replaceCellFromIndex:(int)fromIndex toIndex:(int)toIndex {
    ComplexTableCell *cell = [self getCellAtIndex:fromIndex];
    [cell retain];
    [allCells removeObjectAtIndex:fromIndex];
    [allCells insertObject:cell atIndex:toIndex];
    [cell release];
    [self rebuildCurrentCells];
}


/*  
 -----------------------------------------------------------------------  
 - method that rebuilds the current Cells  
 - Relates to allCells
 
*/


-(void) rebuildCurrentCells {
    [currentCells removeAllObjects];
    int numberOfAllCells = [allCells count];
    for(int x = 0;x < numberOfAllCells; x++) {
        ComplexTableCell *cell = [allCells objectAtIndex:x];
        if(cell.hidden == NO) {
            [currentCells addObject:cell];
        }
    }
}


/*  
 -----------------------------------------------------------------------  
 - method to check if cell is in section
 - Relates to allCells
 
*/

-(BOOL) isCellInSection:(ComplexTableCell*) searchCell {
    for(int x = 0; x < [allCells count]; x++) {
        ComplexTableCell *cell = [allCells objectAtIndex:x];
        if(cell == searchCell) {
            return TRUE;
        }
    }
    return FALSE;
}




/*  
 -----------------------------------------------------------------------  
 - Dealloc method

*/

-(void) dealloc {
    [currentCells removeAllObjects];
    [allCells removeAllObjects];
    
    [currentCells release];
    [sectionName release];
    
    [titleHeader release];
    [titleFooter release];
    [headerView release];
    [footerView release];
    [allCells release];
    [super dealloc];
}

@end
