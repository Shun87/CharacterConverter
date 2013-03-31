//
//  SystemViewController.h
//  CharacterConverter
//
//  Created by chenshun on 13-3-31.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
@class TTSocial;
@interface SystemViewController : UIViewController
{
    IBOutlet UIBarButtonItem *cancelButton;
    IBOutlet UILabel *lable1;
    IBOutlet UILabel *lable2;
    TTSocial *socila;
    MainViewController *main;
}
@property (nonatomic, assign) MainViewController *main;
- (IBAction)Cancle:(id)sender;
@end
