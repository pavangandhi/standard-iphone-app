//
//  AllRecordsView.h
//  weltrekorde
//
//  Created by Alexander Herbel on 08.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImportFile.h"
#import <AVFoundation/AVFoundation.h>
#import "AsyncUIImage.h"

// LANG(@"KEY",nil);
// COMMANDLINE genstrings -s LANG -o standard-iphone-app/en.lproj/ *.m
#define LANG(key,comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:(comment) table:nil]


@interface CategoriesView : UIViewController <UITabBarDelegate> {
    ComplexTableView *tbl_categories;
}

-(void) createTable;

@end
