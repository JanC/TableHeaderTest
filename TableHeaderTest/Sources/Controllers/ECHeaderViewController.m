//
// Created by Jan Chaloupecky on 14/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "ECHeaderViewController.h"
#import "ECHeaderView.h"

@interface ECHeaderViewController () <ECHeaderViewDelegate>

@property(nonatomic, assign) NSInteger count;
@property(nonatomic, strong) UILabel *countLabel;
@end

@implementation ECHeaderViewController
{
}

- (void)loadView
{
    [super loadView];

    self.view.backgroundColor = [UIColor lightGrayColor];

    ECHeaderView *headerView = [[ECHeaderView alloc] init];
    headerView.delegate = self;
    [self.view addSubview:headerView];

    self.countLabel = [[UILabel alloc] init];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.countLabel];
    self.countLabel.text = @"count 0";
    self.countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //
    // Auto Layout
    //
    headerView.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(headerView, _countLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView]|" options:0 metrics:nil  views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView]" options:0 metrics:nil  views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_countLabel]|" options:0 metrics:nil  views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerView][_countLabel]|" options:0 metrics:nil  views:views]];
}

- (void)didIncrement
{
    self.count++;
    [self updateCount];

}

- (void)didDecrement
{
    self.count--;
    [self updateCount];
}

-(void) updateCount
{
    NSString *countText = [NSString stringWithFormat:@"count %d", self.count];
    NSLog(@"%@", countText);
    self.countLabel.text = countText;

}

@end