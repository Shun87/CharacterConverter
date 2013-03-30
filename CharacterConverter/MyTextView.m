//
//  MyTextView.m
//  CharacterConverter
//
//  Created by chenshun on 13-3-30.
//  Copyright (c) 2013年 ChenShun. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    if (action == @selector(copy:))
//        return NO;
//    if (action == @selector(cut:))
        return NO;
    if (action == @selector(copy:))
    {
        
    }
    //return [super canPerformAction:action withSender:sender];
}

@end
