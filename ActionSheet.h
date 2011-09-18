//
//  ActionSheet.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BlockButton.h"

@interface ActionSheet : UIActionSheet <UIActionSheetDelegate> {
    NSMutableArray *blockButtons;
}

-(id)initWithTitle:(NSString *)title cancelButton:(BlockButton *)cancelButtonItem redButton:(BlockButton*) redButtonItem otherButtons:(NSArray *)otherButtonItems;

@end
