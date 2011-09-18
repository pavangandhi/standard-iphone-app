//
//  UIImage-Extensions.h
//  standard-iphone-app
//
//  Created by Alexander Herbel on 18.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (UIImage_Extensions)

-(UIImage*)scaleToSize:(CGSize)size;
+ (id) imageNamedNoCache:(NSString *)name;
@end
