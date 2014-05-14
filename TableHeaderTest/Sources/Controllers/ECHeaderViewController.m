//
// Created by Jan Chaloupecky on 14/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "ECHeaderViewController.h"
#import "ECHeaderView.h"

@implementation ECHeaderViewController
{
}

- (void)loadView
{
    [super loadView];

    self.view.backgroundColor = [UIColor lightGrayColor];


    UIView *headerView = [[ECHeaderView alloc] init];
    [self.view addSubview:headerView];


    //
    // Auto Layout
    //
    headerView.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(headerView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:nil  views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView]" options:0 metrics:nil  views:views]];
}

@end