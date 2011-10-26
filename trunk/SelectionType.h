//
//  ListSelectionArrayType.h
//  RedCarper
//
//  Created by Alexander Herbel on 19.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SelectionType : NSObject {
    NSString *s_labelText;
    NSString *s_detailText;
    NSString *s_returnValue;
    NSInteger i_returnValue;
    UIImage *ui_image;
}

@property (nonatomic,retain) NSString *s_labelText;
@property (nonatomic,retain) NSString *s_detailText;
@property (nonatomic,retain) NSString *s_returnValue;
@property (nonatomic) NSInteger i_returnValue;
@property (nonatomic,retain) UIImage *ui_image;

@end
