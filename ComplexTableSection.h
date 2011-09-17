//
//  ComplexTableSection.h
//  RedCarper
//
//  Created by Alexander Herbel on 13.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ComplexTableSection : NSObject {
    
@public
    NSString *titleHeader;
    NSString *titleFooter;
    
    NSString *titleHeaderWhenNoRows;
    NSString *titleFooterWhenNoRows;
    

    
    UIView *headerView;
    UIView *footerView;
    BOOL showWhenNoRows;
    
@private 
    BOOL hidden;
    NSMutableArray *allCells; 
    NSMutableArray *currentCells;
    NSString *sectionName;    
}

@property (nonatomic) BOOL hidden;
@property (nonatomic) BOOL showWhenNoRows;
@property (nonatomic,retain) NSString *sectionName;
@property (nonatomic,retain) NSString *titleHeader;
@property (nonatomic,retain) NSString *titleFooter;
@property (nonatomic,retain) NSString *titleHeaderWhenNoRows;
@property (nonatomic,retain) NSString *titleFooterWhenNoRows;

@property (nonatomic,retain) UIView *headerView;
@property (nonatomic,retain) UIView *footerView;
@property (nonatomic,retain) NSMutableArray *allCells;
@property (nonatomic,retain) NSMutableArray *currentCells;


-(ComplexTableCell*) addCell:(NSString*) cellName andTitel:(NSString*) titetText andCellType:(UITableViewCellStyle) style; 

-(ComplexTableCell*) insertCell:(NSString*) cellName andTitel:(NSString*) titetText andCellType:(UITableViewCellStyle) style AtIndex:(int) index;

-(void) addComplexCell:(ComplexTableCell*)cell;
-(void) addComplexCell:(ComplexTableCell*)cell AtIndex:(int) index;

-(int) getNumberOfAllCells;
-(int) getNumberOfVisibleCells;

-(ComplexTableCell*) getCellAtIndex:(int) index;
-(ComplexTableCell*) getCellWithCellName:(NSString*)cellName;

-(void) checkSectionForVisibility;
-(void) removeCell:(ComplexTableCell*) cell;
-(void) removeCellWithName:(NSString*)cellName;
-(void) removeCellAtIndex:(int) index;

-(void) hideCell:(BOOL) yesNo atIndex:(int) index;
-(void) hideCell:(BOOL) yesNo withCellName:(NSString*) cellName;

-(void) replaceCellFromIndex:(int)fromIndex toIndex:(int)toIndex;
-(void) rebuildCurrentCells;

-(BOOL) isCellInSection:(ComplexTableCell*) searchCell;

@end
