//
//  ComplexTableCell.h
//  RedCarper
//
//  Created by Alexander Herbel on 13.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ComplexTableCell : UITableViewCell {
    @public
        NSMutableArray *infos;
        BOOL canEditCell;
        BOOL canMoveCell;
        NSInteger cellHeight;
        NSString *cellName;
        SEL didSelectSelector;
        SEL didDeleteSelector;
        SEL didSelectAccessorSelector;
        SEL didMoveSelector;
        NSInteger editStyle;
        NSMutableArray *searchTextArray;
    
    @private
        BOOL hidden;
}

@property (nonatomic,retain) NSMutableArray *infos;
@property (nonatomic) BOOL canEditCell;
@property (nonatomic) BOOL canMoveCell;
@property (nonatomic) NSInteger cellHeight;
@property (nonatomic,retain) NSString *cellName;
@property (nonatomic) SEL didSelectSelector;
@property (nonatomic) SEL didDeleteSelector;
@property (nonatomic) SEL didSelectAccessorSelector;
@property (nonatomic) SEL didMoveSelector;
@property (nonatomic) NSInteger editStyle;
@property (nonatomic) BOOL hidden;
@property (nonatomic,retain)  NSMutableArray *searchTextArray;

@end
