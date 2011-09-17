//
//  AllRecordsView.h
//  weltrekorde
//
//  Created by Alexander Herbel on 08.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImportFile.h"
#import <AVFoundation/AVFoundation.h>

@interface CategoriesView : UIViewController <UITabBarDelegate> {
    ComplexTableView *tbl_categories;
}

-(void) createTable;

@end
