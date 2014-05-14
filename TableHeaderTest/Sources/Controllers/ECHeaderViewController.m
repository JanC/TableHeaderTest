//
// Created by Jan Chaloupecky on 14/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "ECHeaderViewController.h"
#import "ECCustomView.h"

@implementation ECHeaderViewController
{
}

- (void)loadView
{
    [super loadView];

    self.view.backgroundColor = [UIColor lightGrayColor];


    UIView *customView = [[ECCustomView alloc] init];

    [self.view addSubview:customView];

    //
    // Auto Layout
    //
    customView.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(customView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[customView]|" options:0 metrics:nil  views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[customView]" options:0 metrics:nil  views:views]];
}

@end