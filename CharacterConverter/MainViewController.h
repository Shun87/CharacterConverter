//
//  MainViewController.h
//  CharacterConverter
//
//  Created by chenshun on 13-3-29.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"

@interface MainViewController : UIViewController
{
    IBOutlet MyTextView *textView;
    IBOutlet UISlider *slideFontSize;
    IBOutlet UIView *toolView;
    CGRect oldRect;
}

@property (nonatomic, retain)IBOutlet MyTextView *textView;
- (IBAction)copyAction:(id)sender;
- (IBAction)pasteAction:(id)sender;
- (IBAction)bigToSimple:(id)sender;
- (IBAction)SimpleTobig:(id)sender;
- (IBAction)clearAction:(id)sender;
- (IBAction)selectFont:(id)sender;
- (IBAction)selectColor:(id)sender;
- (IBAction)fontSizeChange:(id)sender;
- (IBAction)Ok:(id)sender;
@end

