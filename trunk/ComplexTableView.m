//
//  ComplexTableView.m
//  RedCarper
//
//  Created by Alexander Herbel on 13.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ComplexTableView.h"



@implementation ComplexTableView

@synthesize functionDelegate;
@synthesize debug;
@synthesize isKeyboardOpen;


/*  
 ----------------------------------------------------------------------- 
 - method init complex table view
 
*/

- (id)initWithStyle:(UITableViewStyle)style andNavi:(BOOL) n Toolbar:(BOOL) t CustomSearcbar:(BOOL) s {

    if (self == [super initWithFrame:CGRectMake(0, 0, [self getWidth], [self getHeightWithNavi:n Toolbar:t Searchbar:s Keyboard:NO]) style:style]) {
        allSections = [[NSMutableArray alloc] init];
        currentSections = [[NSMutableArray alloc] init];
        searchBarSection = [ComplexTableSection new];
        _navigationBarExists = n;
        _toolbarExists = t;
        _customSearchBarExists = s;
        
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}


-(void) showKeyboard {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [self resetFrame];
    [UIView commitAnimations]; 
}

-(void) hideKeyboard {

    [self resetFrame];
}



-(void) resetFrame { 
    [self setFrame:CGRectMake(0, 0, [self getWidth], [self getHeightWithNavi:_navigationBarExists Toolbar:_toolbarExists Searchbar:_customSearchBarExists Keyboard:isKeyboardOpen])];
}

/*  
 ----------------------------------------------------------------------- 
 - methods that relate to searchbar
 
 */

#pragma mark -
#pragma mark Searchbar Functions



- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
    if(debug == YES) NSLog(@"searchBarSearchButtonClicked");
    isKeyboardOpen = NO;
    [theSearchBar setShowsCancelButton:NO animated:YES];
    [theSearchBar resignFirstResponder];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    if(debug == YES) NSLog(@"searchBarCancelButtonClicked");
    [searchBar resignFirstResponder];
    isKeyboardOpen = NO;
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
    if(debug == YES) NSLog(@"searchBarTextDidBeginEditing");
    isKeyboardOpen = YES;
    [theSearchBar setShowsCancelButton:YES animated:YES];
    [theSearchBar sizeToFit];
}

- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
    if(debug == YES) NSLog(@"searchbar textDidChange");
    isKeyboardOpen = YES;
    [searchBarSection.currentCells removeAllObjects];
    [searchBarSection.allCells removeAllObjects];
    [self reloadData];
}

-(UISearchBar*) getSearchbar {
    if(debug == YES) NSLog(@"getSearchbar");
    return _searchBar;
}

-(void) setSearchbar:(UISearchBar*) searchBar {
    if(debug == YES) NSLog(@"setSearchbar:");
    _searchBar = searchBar;
    _customSearchbarSetted = YES;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   if(debug == YES) NSLog(@"scrollViewDidScroll");
    if(_searchBar != nil && _customSearchbarSetted == FALSE) {
        CGRect rect = _searchBar.frame;
        rect.origin.y = MIN(0, scrollView.contentOffset.y);
        _searchBar.frame = rect;
    }
}




-(void) hideSearchbar {
    if(debug == YES) NSLog(@"hideSearchbar");
    if(_searchBar!=nil) {
        _searchBar.text = @"";
        [_searchBar setShowsCancelButton:NO animated:NO];
    }
    self.tableHeaderView = nil;
}

-(void) showSearchbar {
    if(debug == YES) NSLog(@"showSearchbar");
    if(_searchBar != nil) {
        self.tableHeaderView = _searchBar;
    }
}


-(void) searchForText:(NSString*)text {
    if(debug == YES) NSLog(@"searchForText:");
    [searchBarSection.currentCells removeAllObjects];
    [searchBarSection.allCells removeAllObjects];
    
    for(int x=0;x<[currentSections count];x++) {
        ComplexTableSection *section = [currentSections objectAtIndex:x];
        for(int y=0;y<[section.currentCells count];y++) {
            ComplexTableCell *cell = [section.currentCells objectAtIndex:y];
            for (NSString *sTemp in cell.searchTextArray) {
                NSRange titleResultsRange = [sTemp rangeOfString:text options:NSCaseInsensitiveSearch];
                        
                if (titleResultsRange.length > 0) {
                    [searchBarSection addComplexCell:cell];
                    break;
                }
            }
        }
    }     
}



-(UISearchBar*) addSearchbar {
    if(debug == YES) NSLog(@"addSearchbar");
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    _searchBar.delegate = self;
    _searchBar.barStyle=UIBarStyleDefault;
    _searchBar.showsCancelButton=NO;
    _searchBar.autocorrectionType=UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.tableHeaderView = _searchBar;
    return _searchBar;
}



#pragma mark -
#pragma mark Section Functions


-(ComplexTableSection*) createSection:(NSString*)sectionName andTitel:(NSString*)titel {
    ComplexTableSection *section = [ComplexTableSection new];

    section.hidden = NO;    
    section.showWhenNoRows = NO;
    
    section.titleHeader = titel;
    section.sectionName = sectionName;
    
    [allSections addObject:section];
    [currentSections addObject:section];
    [section release];
    
    return section;
}


-(ComplexTableSection*) insertSection:(NSString*)sectionName andTitel:(NSString*)titel atIndex:(int)index {
    ComplexTableSection *section = [ComplexTableSection new];
    
    section.hidden = NO;    
    section.showWhenNoRows = NO;
    
    section.titleHeader = titel;
    section.sectionName = sectionName;
    
    [allSections insertObject:section atIndex:index];  
    [self rebuildSections];
    [section release];
    
    return section;
}


-(void) rebuildSections {
    if(debug == YES) NSLog(@"rebuildSections");
    
    [currentSections removeAllObjects];
    for(int x = 0; x < [self getNumberOfVisibleSections]; x++) {
        ComplexTableSection *section = [allSections objectAtIndex:x];
        if(section.hidden == NO && ([section getNumberOfVisibleCells] == 0 && section.showWhenNoRows == YES)) {
            [currentSections addObject:section];
        }
    }
}


-(ComplexTableSection*) getSearchBarSection {
    return searchBarSection;
}


-(int) getSectionIdForSection:(ComplexTableSection*) section {
    
    for(int x = 0; x < [currentSections count]; x++) {
        if(section == [currentSections objectAtIndex:x]) {
            return x;
        }        
    }
    return -1;
}



-(int) getSectionIdForName:(NSString*) sectionName {
    
    for(int x = 0; x < [currentSections count]; x++) {
        ComplexTableSection *section = [currentSections objectAtIndex:x];
        if([section.sectionName isEqualToString:sectionName]) {
            return x;
        }        
    }
    return -1;
}


-(ComplexTableSection*) getSectionWithName:(NSString*) sectionName {
    ComplexTableSection *section = nil;    
    int numberOfAllSections = [allSections count];
    
    for(int x=0;x < numberOfAllSections ;x++) {
        section = [allSections objectAtIndex:x];
        if([section.sectionName isEqualToString:sectionName]) {
            return section;
        }
    }    
    
    return nil;
}


-(ComplexTableSection*) getSectionAtIndex:(int) index {
    return [currentSections objectAtIndex:index];
}


-(void) removeSectionWithName:(NSString*) sectionName {
    ComplexTableSection *section = [self getSectionWithName:sectionName];
    [currentSections removeObject:section];
    [allSections removeObject:section];
}

-(void) removeSectionAtIndex:(int) index {
    ComplexTableSection *section = [self getSectionAtIndex:index];
    [currentSections removeObject:section];
    [allSections removeObject:section];
}


-(void) hideSection:(BOOL) yesNo withName:(NSString*) sectionName {
    ComplexTableSection *tmpSection = [self getSectionWithName:sectionName];
    tmpSection.hidden = yesNo;
    
    if(yesNo == YES) {
        [currentSections removeObject:tmpSection];
    } else {
        [self rebuildSections];
    }
}

-(void) hideSection:(BOOL) yesNo atIndex:(int) index {
    ComplexTableSection *tmpSection = [self getSectionAtIndex:index];
    tmpSection.hidden = yesNo;
    
    if(yesNo == YES) {
        [currentSections removeObject:tmpSection];
    } else {
        [self rebuildSections];
    }
}


-(int) getNumberOfAllSection {
    return [allSections count];
}

-(int) getNumberOfVisibleSections {
    
    if([_searchBar.text length]>0) {
        [self searchForText:_searchBar.text];
        return 1;
    }
    
    return [currentSections count];
}

#pragma mark -
#pragma mark Cell Function


-(id) getCellWithIndexPath:(NSIndexPath*)indexPath {
    ComplexTableSection *tmpSection = [self getSectionAtIndex:indexPath.section];
    return [tmpSection getCellAtIndex:indexPath.row];
}


-(id) getCellWithCellName:(NSString*)cellName {
    ComplexTableCell *cell = nil;

    for(int x = 0;x<[allSections count];x++) {
        ComplexTableSection *tmpSection = [allSections objectAtIndex:x];
        cell = [tmpSection getCellWithCellName:cellName];
        if(cell != nil) {
            return cell;
        }
    }
    return nil;
}


-(ComplexTableSection*) getSectionWithComplexCell:(ComplexTableCell*) cell {
    for(int x = 0;x<[allSections count];x++) {
        ComplexTableSection *tmpSection = [allSections objectAtIndex:x];
        if([tmpSection isCellInSection:cell]==TRUE) {
            return tmpSection;
        }
    }
    return  nil;
}


#pragma mark -
#pragma mark TableViewDelegate Functions


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(debug == TRUE) NSLog(@"titleForHeaderInSection");
    
    
    
    // Wenn etwas in Searchbox steht
    if([_searchBar.text length] > 0) {
        if([searchBarSection getNumberOfVisibleCells]==0) {
            if([searchBarSection.titleHeaderWhenNoRows isNotEmpty]) {
                return [NSString stringWithFormat:searchBarSection.titleHeaderWhenNoRows,_searchBar.text];
            } else {
                return nil;
            }
        }
        return searchBarSection.titleHeader;
    } 
    
    ComplexTableSection *tmpSection = [self getSectionAtIndex:section];
    if([tmpSection getNumberOfVisibleCells]==0) {

        return tmpSection.titleHeaderWhenNoRows;
    }
    return tmpSection.titleHeader;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if(debug == TRUE) NSLog(@"titleForFooterInSection");
    
    
    if([_searchBar.text length] > 0) {
        if([searchBarSection getNumberOfVisibleCells]==0) {
            if([searchBarSection.titleFooterWhenNoRows isNotEmpty]) {
                return [NSString stringWithFormat:searchBarSection.titleFooterWhenNoRows,_searchBar.text];
            } else {
                return  nil;
            }
        }
        return searchBarSection.titleFooter;
    } 
    
    ComplexTableSection *tmpSection = [self getSectionAtIndex:section];
    if([tmpSection getNumberOfVisibleCells]==0) {
        return tmpSection.titleFooterWhenNoRows;
    }
    return tmpSection.titleFooter;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(debug == TRUE) NSLog(@"heightForRowAtIndexPath");
    ComplexTableCell *cell = nil;
    
    if([_searchBar.text length] > 0) {
        cell = [searchBarSection.currentCells objectAtIndex:indexPath.row]; 
    } else {
        cell = [self getCellWithIndexPath:indexPath];
    }
    
    return cell.cellHeight;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(debug == TRUE)  NSLog(@"numberOfRowsInSection");
    
    if([_searchBar.text length] > 0) {
        int numberOfRows = [searchBarSection getNumberOfVisibleCells];
        if(debug == TRUE) NSLog(@"SEARCHBAR NUMBER OF ROWS: %i",numberOfRows);
        return numberOfRows; 
    }
    
    ComplexTableSection *tmpSection = [self getSectionAtIndex:section];
    
    int numberOfRows = [tmpSection getNumberOfVisibleCells];
    if(debug == TRUE) NSLog(@"NORMAL SECTION NUMBER OF ROWS: %i",numberOfRows);
    return numberOfRows;
}



- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if(debug == TRUE)  NSLog(@"accessoryButtonTappedForRowWithIndexPath");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(debug == TRUE)  NSLog(@"cellForRowAtIndexPath");
    if([_searchBar.text length] > 0) {
        return [searchBarSection.currentCells objectAtIndex:indexPath.row]; 
    }
    
    return [self getCellWithIndexPath:indexPath];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(debug == TRUE) NSLog(@"didSelectRowAtIndexPath");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ComplexTableCell *cell = nil;
    
    if([_searchBar.text length] > 0) {
        cell = [searchBarSection.currentCells objectAtIndex:indexPath.row]; 
    } else {
        cell = [self getCellWithIndexPath:indexPath];
    }
    
    if(cell.didSelectSelector != nil)
    [functionDelegate performSelector:[cell didSelectSelector] withObject:indexPath];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(debug == TRUE) NSLog(@"numberOfSectionsInTableView");
    return [self getNumberOfVisibleSections];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(debug == TRUE) NSLog(@"editingStyleForRowAtIndexPath");
    ComplexTableCell *cell = nil;
    
    if([_searchBar.text length] > 0) {
       cell = [searchBarSection.currentCells objectAtIndex:indexPath.row]; 
    } else {
        cell = [self getCellWithIndexPath:indexPath];
    }
    
    return cell.editStyle;
}


-(void) tblBeginUpdates {
    if(debug == TRUE) NSLog(@"tblBeginUpdates");
    [self beginUpdates];
}

-(void) animateRemovingCellAtIndexPath:(NSIndexPath*)indexPath {
    if(debug == TRUE) NSLog(@"animateRemovingCellAtIndexPath");
    [self deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

-(void) tblEndUpdates {
    if(debug == TRUE) NSLog(@"tblEndUpdates");
    [self endUpdates];
}




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(debug == TRUE) NSLog(@"commitEditingStyle");
    ComplexTableCell *cell = nil;

    if([_searchBar.text length] > 0) {
        cell = [searchBarSection.currentCells objectAtIndex:indexPath.row]; 
    } else {
        cell = [self getCellWithIndexPath:indexPath];
    }

    if (editingStyle == UITableViewCellEditingStyleDelete && cell.didDeleteSelector != nil)
    {
        [functionDelegate performSelector:[cell didDeleteSelector] withObject:indexPath];
    }
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if(debug == TRUE) NSLog(@"canMoveRowAtIndexPath");
    ComplexTableCell *cell = [self getCellWithIndexPath:indexPath];
    
    if([_searchBar.text length] > 0) {
        return NO;
    }
    return cell.canMoveCell;
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if(debug == TRUE) NSLog(@"moveRowAtIndexPath");
    ComplexTableCell *cell = [self getCellWithIndexPath:sourceIndexPath];
    ComplexTableSection *section = [self getSectionAtIndex:sourceIndexPath.section];
    [section replaceCellFromIndex:sourceIndexPath.row toIndex:sourceIndexPath.row];
    if(cell.didMoveSelector!=nil) {
        [functionDelegate performSelector:[cell didMoveSelector] withObject:sourceIndexPath withObject:destinationIndexPath];
    }
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(debug == TRUE) NSLog(@"canEditRowAtIndexPath");
    ComplexTableCell *cell = nil;
    
    if([_searchBar.text length] > 0) {
        cell = [searchBarSection.currentCells objectAtIndex:indexPath.row]; 
    } else {
        cell = [self getCellWithIndexPath:indexPath];
    }
  
    return cell.canEditCell;
}


// Alphabetic Letter beside the UITableView

-(NSMutableArray*) getArrayWithLetters {
    NSMutableArray *stateIndex = [NSMutableArray array];
    
    for (int i=0; i<[alphabeticSource count]-1; i++){
        char alphabet = [[alphabeticSource objectAtIndex:i] characterAtIndex:0];
        NSString *uniChar = [NSString stringWithFormat:@"%C", alphabet];
        
        if (![stateIndex containsObject:uniChar])
        {            
            [stateIndex addObject:uniChar];
        }        
    }

    return stateIndex;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if(alphabeticSource==nil) return nil;
    return [self getArrayWithLetters];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index {
    NSInteger count = 0;
    NSMutableArray *alphabeticalArray = [self getArrayWithLetters];
    for(NSString *character in alphabeticalArray )
    {
        if([character isEqualToString:title]) {
            return count;
        }    
        count ++;
    }
    
    return 0;
}


-(int) getHeightWithNavi:(BOOL) n Toolbar:(BOOL) t Searchbar:(BOOL) s Keyboard:(BOOL) k {
    
    if(DeviceType == Phone) {
        int height = 460;
        int keyboardHeight = 216;
        int navigationHeight = 44;
        int toolbarHeight = 49;
        
        if(n == true) height = height - navigationHeight;
        if(t == true && k == false) height = height - toolbarHeight;
        if(s == true) height = height - 44;
        if(k == true) height = height - keyboardHeight;
   
        return height;   
        
    } else {
        int height = 1004;
        int keyboardHeight = 264;
        
        if(n == true) height = height - 44;
        if(t == true && k == false) height = height - 49;
        if(s == true) height = height - 44;
        if(k == true) height = height - keyboardHeight;
        return height;   
    }
    
    return 60;
}





-(int) getWidth {
    
    int width = 320;
    if(DeviceType == Pad) {
        width = 768;
    }
    
    return width;
}




-(CGRect) rectSwap:(CGRect) rect {
	CGRect newRect;
	newRect.origin.x = rect.origin.y;
	newRect.origin.y = rect.origin.x;
	newRect.size.width = rect.size.height;
	newRect.size.height = rect.size.width;
	return newRect;
}



-(void) removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard) name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard) name: UIKeyboardWillHideNotification object:nil];
}


-(void) clearTable {
    if(debug == TRUE) NSLog(@"clearTable");
    [allSections removeAllObjects];
    [currentSections removeAllObjects];
}


-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.delegate = nil;
    self.dataSource = nil;
    _searchBar.delegate = nil;
    [_searchBar release];    
    [allSections release];
    [currentSections release];
    [searchBarSection release];
    [super dealloc];
}


@end
