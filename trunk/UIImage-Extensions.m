//
//  UIImage-Extensions.m
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage-Extensions.h"


@implementation UIImage (UIImage_Extensions)

+ (id) imageNamedNoCache:(NSString *)name
{
    NSString *basename = [name stringByDeletingPathExtension];
    NSString *extension = [name pathExtension];
    NSString *path = [[NSBundle mainBundle] pathForResource:basename ofType:extension];
    return [[[UIImage alloc] initWithContentsOfFile:path] autorelease];
}

-(UIImage*)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}




@end
