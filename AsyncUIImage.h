//
//  AsyncUIImage.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"


@interface AsyncUIImage : UIView {
    ASIHTTPRequest *imageRequest;
    UIActivityIndicatorView *indicator;
    BOOL didLoadImage;
}

- (void)loadImageFromURL:(NSString*)imageUrl;
- (UIImage*) image;
@end
