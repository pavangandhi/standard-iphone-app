//
//  AsyncUIImage.m
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsyncUIImage.h"
#import "UIImage-Extensions.h"

@implementation AsyncUIImage


- (void)loadImageFromURL:(NSString*)imageUrl {
    if(didLoadImage == YES) 
        return;
    
    if(imageRequest != nil) {
        [imageRequest cancel];
        [imageRequest release];
    }
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    imageRequest = [ASIHTTPRequest requestWithURL:url];
    [imageRequest setDelegate:self];
    [imageRequest startAsynchronous];
      
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(10, 10, 20.0f, 20.0f);
    [self addSubview:indicator];
    [indicator startAnimating];
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    [indicator removeFromSuperview];
    UIImage *imageFromData = [UIImage imageWithData:[request responseData]];
    
    if(self.bounds.size.width < imageFromData.size.width) {
        float ratio = self.bounds.size.width / imageFromData.size.width;
        imageFromData = [imageFromData scaleToSize:CGSizeMake(imageFromData.size.width*ratio, imageFromData.size.height*ratio)];
    }

    if(self.bounds.size.height < imageFromData.size.height) {
        float ratio = self.bounds.size.height / imageFromData.size.height;
        imageFromData = [imageFromData scaleToSize:CGSizeMake(imageFromData.size.width*ratio, imageFromData.size.height*ratio)];
    }    
    
    UIImageView* imageView = [[UIImageView alloc] initWithImage:imageFromData];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    imageView.frame = self.bounds;
    [imageView release];

    didLoadImage = YES;    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Error: Could not load async image");
}

- (void)dealloc {
    [imageRequest cancel];
    [imageRequest release];
    [indicator release];
    [super dealloc];
}

- (UIImage*) image {
    UIImageView* iv = [[self subviews] objectAtIndex:0];
    return [iv image];
}

@end
