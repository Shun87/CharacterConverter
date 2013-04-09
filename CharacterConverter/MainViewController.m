//
//  MainViewController.m
//  CharacterConverter
//
//  Created by chenshun on 13-3-29.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "MainViewController.h"
#import "NSString+Conveter.h"
#import <AdSupport/ASIdentifierManager.h>
#import "SystemViewController.h"

#define HEXCOLOR(rgbValue, alpa) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpa]

#define kSampleAdUnitID @"a151580514025fa";
#define TESTMODE 1

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize textView;
@synthesize adBanner = adBanner_;
- (void)dealloc
{
    [bannerView_ release];
    [textView release];
    [super dealloc];
}

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
 
    slideFontSize.minimumValue = 16;
    slideFontSize.maximumValue = 50;
    slideFontSize.value = 25;
    [slideFontSize setMinimumTrackTintColor:HEXCOLOR(0x545d6a, 1)];
    
    self.textView.font = [UIFont systemFontOfSize:slideFontSize.value];

    [self.view addSubview:toolView];
    CGRect rect = self.textView.frame;
    oldRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    CGRect accesoryViewRect = CGRectMake(0, 0, 320, 30);
    UIView *accessoryView = [[UIView alloc]initWithFrame:accesoryViewRect];
    accessoryView.backgroundColor = [UIColor clearColor];
    CGRect buttonRect = CGRectMake(320 - 58, 0, 55, 30);
    hideButton = [[UIButton alloc] initWithFrame:buttonRect];
    [hideButton setBackgroundImage:[UIImage imageNamed:@"barButtonBK"] forState:UIControlStateNormal];
    [hideButton setTitle:NSLocalizedString(@"hide", nil) forState:UIControlStateNormal];
    [hideButton setTitle:NSLocalizedString(@"hide", nil) forState:UIControlStateHighlighted];
    [hideButton addTarget:self action:@selector(hideKey:) forControlEvents:UIControlEventTouchUpInside];
    [accessoryView addSubview:hideButton];
    textView.inputAccessoryView = accessoryView;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [copyButton setTitle:NSLocalizedString(@"Copy", nil) forState:UIControlStateNormal];
    [pasteButton setTitle:NSLocalizedString(@"paste", nil) forState:UIControlStateNormal];
    [clearButton setTitle:NSLocalizedString(@"clear", nil) forState:UIControlStateNormal];
    [simpleButton setTitle:NSLocalizedString(@"simplified", nil) forState:UIControlStateNormal];
    [bigButton setTitle:NSLocalizedString(@"traditional", nil) forState:UIControlStateNormal];
    [shareButton setTitle:NSLocalizedString(@"share", nil) forState:UIControlStateNormal];
    [aboutButton setTitle:NSLocalizedString(@"about", nil) forState:UIControlStateNormal];
    [hideButton setTitle:NSLocalizedString(@"hide", nil) forState:UIControlStateNormal];
    
    social = [[TTSocial alloc] init];
    social.viewController = self;
    
    // Initialize the banner at the bottom of the screen.
    CGPoint origin = CGPointMake(0.0,
                                 self.view.frame.size.height -
                                 CGSizeFromGADAdSize(kGADAdSizeBanner).height);
    
    // Use predefined GADAdSize constants to define the GADBannerView.
    self.adBanner = [[[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner
                                                    origin:origin]
                     autorelease];
    
    // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID
    // before compiling.
    self.adBanner.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.adBanner.adUnitID = kSampleAdUnitID;
    self.adBanner.delegate = self;
    [self.adBanner setRootViewController:self.navigationController];
    [self.view addSubview:self.adBanner];
    self.adBanner.center =
    CGPointMake(self.view.center.x, self.adBanner.center.y);
    [self.adBanner loadRequest:[self createRequest]];
}


- (IBAction)hideKey:(id)sender
{
    [self.textView resignFirstResponder];
}

#pragma mark GADRequest generation

// Here we're creating a simple GADRequest and whitelisting the application
// for test ads. You should request test ads during development to avoid
// generating invalid impressions and clicks.
- (GADRequest *)createRequest {
    GADRequest *request = [GADRequest request];
    
    return request;
}

#pragma mark GADBannerViewDelegate impl

// We've received an ad successfully.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"Received ad successfully");
}

- (void)adView:(GADBannerView *)view
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"Failed to receive ad with error: %@", [error localizedFailureReason]);
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect textViewRect = self.textView.frame;
    textViewRect.size.height = rect.size.height - keyboardRect.size.height - 20 - textViewRect.origin.y;
    self.textView.frame = textViewRect;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration =
    [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.textView.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y, oldRect.size.width, oldRect.size.height);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)copyAction:(id)sender
{
    [[UIPasteboard generalPasteboard] setValue:self.textView.text forPasteboardType:@"public.utf8-plain-text"];
}

- (IBAction)pasteAction:(id)sender
{
    NSString *pasteText = [[UIPasteboard generalPasteboard] valueForPasteboardType:@"public.utf8-plain-text"];
    
    if (pasteText!=nil) {
        [self.self.textView insertText:pasteText];
    }
}

- (IBAction)bigToSimple:(id)sender
{
    NSString *text = self.textView.text;
    NSString *simpleString = [text simplizeString];
    if (simpleString != nil)
    {
        self.textView.text = simpleString;
    }
}

- (IBAction)SimpleTobig:(id)sender
{
    NSString *text = self.textView.text;
    NSString *bigString = [text traditinalString];
    if (bigString != nil)
    {
        self.textView.text = bigString;
    }
}

- (IBAction)clearAction:(id)sender
{
    self.textView.text = @"";
}

- (IBAction)selectFont:(id)sender
{
    
}

- (IBAction)selectColor:(id)sender
{
    
}

- (IBAction)fontSizeChange:(id)sender
{
    NSInteger size = slideFontSize.value;
    self.textView.font = [UIFont systemFontOfSize:size];
}

- (IBAction)Ok:(id)sender
{
    SystemViewController *setting = [[SystemViewController alloc] initWithNibName:@"SystemViewController" bundle:nil];
    UINavigationController *navgationController = [[UINavigationController alloc] initWithRootViewController:setting];
    [self presentModalViewController:navgationController animated:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == 0)
    {
        [social showSina:self.textView.text];
    }
    else if (buttonIndex == 1)
    {
        [social sendFeedback];
    }
    
}

- (IBAction)systemSetting:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"sina", nil), NSLocalizedString(@"sendfeedback", nil), nil];
    [actionSheet showInView:self.view];
    [actionSheet release];
}

@end
