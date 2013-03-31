//
//  MainViewController.h
//  CharacterConverter
//
//  Created by chenshun on 13-3-29.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"
#import "GADBannerView.h"
#import "TTSocial.h"
@interface MainViewController : UIViewController<GADBannerViewDelegate, UIActionSheetDelegate>
{
    IBOutlet MyTextView *textView;
    IBOutlet UISlider *slideFontSize;
    IBOutlet UIView *toolView;
    CGRect oldRect;
    
    GADBannerView *bannerView_;
    TTSocial *social;
    
    IBOutlet UIButton *copyButton;
    IBOutlet UIButton *pasteButton;
    IBOutlet UIButton *clearButton;
    IBOutlet UIButton *simpleButton;
    IBOutlet UIButton *bigButton;
    IBOutlet UIButton *shareButton;
    IBOutlet UIButton *aboutButton;
    UIButton *hideButton;
}
@property (nonatomic, retain) GADBannerView *adBanner;
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
- (IBAction)systemSetting:(id)sender;

- (GADRequest *)createRequest;
@end

