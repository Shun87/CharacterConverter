//
//  MainViewController.m
//  CharacterConverter
//
//  Created by chenshun on 13-3-29.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "MainViewController.h"
#import "NSString+Conveter.h"

#define HEXCOLOR(rgbValue, alpa) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpa]

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize textView;

- (void)dealloc
{
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
//
    [self.view addSubview:toolView];
    
    CGRect rect = self.textView.frame;
    
    oldRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
//
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
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
    textViewRect.size.height = rect.size.height - keyboardRect.size.height - 20 - textViewRect.origin.y - 44;
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
    [self.textView resignFirstResponder];
}

@end
