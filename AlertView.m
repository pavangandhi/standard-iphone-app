//
//  AlertView.m
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlertView.h"


@implementation AlertView

+(void)initWithMessage:(NSString*)message title:(NSString*)title
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

-(id)initWithMessage:(NSString *)message title:(NSString *)title cancelButton:(BlockButton *)cancelButtonItem otherButtonItems:(NSMutableArray *)otherButtonItems
{
    if((self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonItem.label otherButtonTitles:nil]))
    {
        blockButtons = [NSMutableArray new];
        
        for(BlockButton *item in otherButtonItems)
        {
            [blockButtons addObject:item];
            [self addButtonWithTitle:item.label];
            CLEAR_OBJ(item);
        }
        
        if(cancelButtonItem) {
            [blockButtons insertObject:cancelButtonItem atIndex:0];
            CLEAR_OBJ(cancelButtonItem);
        }
    }
    return self;
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
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
