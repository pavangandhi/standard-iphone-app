//
//  AlertView.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlockButton.h"

@interface AlertView : UIAlertView {
    NSMutableArray *blockButtons;
}

-(id)initWithMessage:(NSString *)message title:(NSString *)title cancelButton:(BlockButton *)cancelButtonItem otherButtonItems:(NSMutableArray *)otherButtonItems;

@end
