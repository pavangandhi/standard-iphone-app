//
//  ActionSheet.m
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ActionSheet.h"


@implementation ActionSheet

-(id)initWithTitle:(NSString *)title cancelButton:(BlockButton *)cancelButtonItem redButton:(BlockButton*) redButtonItem otherButtons:(NSArray *)otherButtonItems {
    
    if((self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
    {
        blockButtons = [NSMutableArray new];
        
        if(redButtonItem)
        {
            [blockButtons addObject:redButtonItem];
            NSInteger destIndex = [self addButtonWithTitle:redButtonItem.label];
            [self setDestructiveButtonIndex:destIndex];
            CLEAR_OBJ(redButtonItem);
        }
        
        if (otherButtonItems)
        {
            for(BlockButton *item in otherButtonItems)
            {
                [blockButtons addObject: item];
                [self addButtonWithTitle:item.label];
                CLEAR_OBJ(item);
            }
        }
        
        if(cancelButtonItem)
        {
            [blockButtons addObject:cancelButtonItem];
            NSInteger cancelIndex = [self addButtonWithTitle:cancelButtonItem.label];
            [self setCancelButtonIndex:cancelIndex];
            CLEAR_OBJ(cancelButtonItem);
        }
        
    }
    return self;
}


- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    BlockButton *item = [blockButtons objectAtIndex:buttonIndex];
    if(item.action) {
        item.action();
    }
}


-(void)dealloc
{
    CLEAR_OBJ(blockButtons);
    [super dealloc];
}


@end
