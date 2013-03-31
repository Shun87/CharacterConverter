//
//  SystemViewController.m
//  CharacterConverter
//
//  Created by chenshun on 13-3-31.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "SystemViewController.h"
#import "TTSocial.h"
#define HEXCOLOR(rgbValue, alpa) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpa]
@interface SystemViewController ()

@end

@implementation SystemViewController
@synthesize main;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"about", nil);
    socila = [[TTSocial alloc] init];
    socila.viewController = self.navigationController;
    self.navigationItem.rightBarButtonItem = cancelButton;
    self.view.backgroundColor = HEXCOLOR(0xf0f7ff, 1);
    cancelButton.title = NSLocalizedString(@"ok", nil);
    lable1.text = NSLocalizedString(@"softversion", nil);
    lable2.text = NSLocalizedString(@"des", nil);
    lable1.textAlignment = UITextAlignmentCenter;
    lable2.numberOfLines = 0;
    
//    self.main.adBanner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    [self.view addSubview:self.main.adBanner];
//    CGFloat height = self.view.frame.size.height - CGSizeFromGADAdSize(kGADAdSizeBanner).height;
//    CGRect rc = self.main.adBanner.frame;
//    rc.origin.y = height;
//    self.main.adBanner.frame = rc;
}

- (IBAction)Cancle:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
@end
