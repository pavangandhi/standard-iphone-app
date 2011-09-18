//
//  BlockButton.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SimpleAction)();

@interface BlockButton : NSObject {
    NSString *label;
    SimpleAction action;
}

@property (retain, nonatomic) NSString *label;
@property (copy, nonatomic) SimpleAction action;

-(id)initWithLabel:(NSString*) string;

@end

