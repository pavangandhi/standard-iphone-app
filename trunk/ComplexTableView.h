//
//  ComplexTableView.h
//  RedCarper
//
//  Created by Alexander Herbel on 13.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ComplexTableView : UITableView <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIScrollViewDelegate> {
@public    
    BOOL debug;
    id functionDelegate;
    NSMutableArray *alphabeticSource;
    NSMutableArray *allSections;
    NSMutableArray *currentSections;
    
    BOOL _navigationBarExists;
    BOOL _toolbarExists;
    BOOL _customSearchBarExists;
    BOOL _customSearchbarSetted;
    BOOL isKeyboardOpen;
  
    
@private
    UISearchBar *_searchBar;
    ComplexTableSection *searchBarSection;
}

@property (assign) id functionDelegate;
@property (nonatomic) BOOL debug;
@property (nonatomic) BOOL isKeyboardOpen;



-(void) resetFrame;
- (id)initWithStyle:(UITableViewStyle)style andNavi:(BOOL) n Toolbar:(BOOL) t CustomSearcbar:(BOOL) s;


-(UISearchBar*) getSearchbar;
-(void) setSearchbar:(UISearchBar*) searchBar;
-(void) searchForText:(NSString*)text;
-(UISearchBar*) addSearchbar;

-(ComplexTableSection*) getSearchBarSection;
-(ComplexTableSection*) createSection:(NSString*)sectionName andTitel:(NSString*)titel;
-(ComplexTableSection*) insertSection:(NSString*)sectionName andTitel:(NSString*)titel atIndex:(int)index;

-(void) hideSearchbar;
-(void) showSearchbar;

-(void) tblBeginUpdates;
-(void) tblEndUpdates;

-(void) rebuildSections;

-(void) animateRemovingCellAtIndexPath:(NSIndexPath*)indexPath;

-(ComplexTableSection*) getSectionWithName:(NSString*) sectionName;
-(ComplexTableSection*) getSectionAtIndex:(int) index;

-(void) removeSectionWithName:(NSString*) sectionName;
-(void) removeSectionAtIndex:(int) index;


-(void) hideSection:(BOOL) yesNo withName:(NSString*) sectionName;
-(void) hideSection:(BOOL) yesNo atIndex:(int) index;

-(int) getNumberOfAllSection;
-(int) getNumberOfVisibleSections;

-(id) getCellWithIndexPath:(NSIndexPath*)indexPath;
-(id) getCellWithCellName:(NSString*)cellName;
-(ComplexTableSection*) getSectionWithComplexCell:(ComplexTableCell*) cell;

-(NSMutableArray*) getArrayWithLetters;

-(int) getHeightWithNavi:(BOOL) n Toolbar:(BOOL) t Searchbar:(BOOL) s Keyboard:(BOOL) k;
-(int) getWidth;


-(void) removeKeyboardObserver;
-(void) addKeyboardObserver;


-(CGRect) rectSwap:(CGRect) rect;
@end
