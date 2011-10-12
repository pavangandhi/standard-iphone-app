//
//  Example_FTCoreText.m
//  standard-iphone-app
//
//  Created by Alexander on 12.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Example_FTCoreText.h"


@implementation Example_FTCoreText

- (NSString *)textForView {
    return @"<title>Article Title</title>\nMaecenas faucibus mollis interdum. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. <black>Curabitur blandit tempus porttitor</black>. Donec ullamcorper nulla non metus auctor fringilla. Sed posuere consectetur est at lobortis.\n\nCras justo odio, dapibus ac facilisis in, egestas eget quam. Nullam quis risus eget urna mollis ornare vel eu leo:\n<bullet /> Fusce dapibus\n<bullet /> tellus ac cursus commodo\n<bullet /> tortor mauris condimentum nibh\n<disclaimer>Ut fermentum massa justo sit amet risus. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</disclaimer>";
}


- (NSMutableDictionary *)coreTextStyle {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
	
    FTCoreTextStyle *defaultStyle = [[FTCoreTextStyle alloc] init];
    [defaultStyle setName:@"_default"];
    defaultStyle.color = [UIColor darkGrayColor];
    defaultStyle.font = [UIFont systemFontOfSize:14];
    [result setValue:defaultStyle forKey:defaultStyle.name];
    [defaultStyle release];
    
    FTCoreTextStyle *blackBold = [[FTCoreTextStyle alloc] init];
    blackBold.name = @"black";
    blackBold.color = [UIColor blackColor];
    blackBold.font = [UIFont boldSystemFontOfSize:14];
    [result setValue:blackBold forKey:blackBold.name];
    [blackBold release];
    
    FTCoreTextStyle *titleStyle = [[FTCoreTextStyle alloc] init];
    titleStyle.name = @"title";
    titleStyle.color = [UIColor redColor];
    titleStyle.font = [UIFont boldSystemFontOfSize:20];
    titleStyle.alignment = kCTCenterTextAlignment;
    [result setValue:titleStyle forKey:titleStyle.name];
    [titleStyle release];
    
    FTCoreTextStyle *disclaimerStyle = [[FTCoreTextStyle alloc] init];
    disclaimerStyle.name = @"disclaimer";
    disclaimerStyle.color = [UIColor blueColor];
    disclaimerStyle.font = [UIFont italicSystemFontOfSize:13];
    [result setValue:disclaimerStyle forKey:disclaimerStyle.name];
    [disclaimerStyle release];
    
    
    FTCoreTextStyle *bullet = [[FTCoreTextStyle alloc] init];
    bullet.name = @"bullet";
    bullet.color = [UIColor purpleColor];
    bullet.font = [UIFont systemFontOfSize:14];
    bullet.appendedCharacter = @"• ";
    [result setValue:bullet forKey:bullet.name];
    [bullet release];    
    return  result;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
    //add coretextview
    FTCoreTextView *coreTextV = [[FTCoreTextView alloc] initWithFrame:CGRectMake(20, 20, 280, 400)];
    // set text
    [coreTextV setText:[self textForView]];
    // set styles
    [coreTextV setStyles:[self coreTextStyle]];
    [self.view addSubview:coreTextV];
    
    [coreTextV release];
    
    
}


@end
