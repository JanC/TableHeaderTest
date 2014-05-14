//
// Created by Jan Chaloupecky on 14/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "ECViewController.h"
#import "ECHeaderViewController.h"

@interface ECViewController ()

@property(nonatomic, strong) ECHeaderViewController *headerViewController;
@end

@implementation ECViewController
{

}

- (id)init
{
    self = [super init];
    if ( self )
    {
        self.title = @"OK";
    }

    return self;
}

- (void)loadView
{
    [super loadView];

    //
    // Setup Table View
    //

    self.automaticallyAdjustsScrollViewInsets = NO;

    self.headerViewController = [[ECHeaderViewController alloc] init];

    [self addChildViewController:self.headerViewController];

    self.headerViewController.view.frame = CGRectZero;
    [self.view addSubview:self.headerViewController.view];
    [self.headerViewController didMoveToParentViewController:self];

    //
    // Auto Layout
    //
    UIView *calendarViewControllerView = self.headerViewController.view;
    id topLayoutGuide = self.topLayoutGuide;
    calendarViewControllerView.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(calendarViewControllerView, topLayoutGuide);
    NSDictionary *metrics = @{

    };

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[calendarViewControllerView]|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][calendarViewControllerView(100)]" options:0 metrics:metrics views:views]];

}

@end