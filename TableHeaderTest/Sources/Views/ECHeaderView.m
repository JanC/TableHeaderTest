//
// Created by Jan Chaloupecky on 14/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "ECHeaderView.h"

@interface ECHeaderView ()

@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIButton *plusButton;
@property(nonatomic, strong) UIButton *minusButton;
@end

@implementation ECHeaderView
{
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {

        self.backgroundColor = [UIColor lightGrayColor];

        self.label = [[UILabel alloc] init];
        self.label.text = @"My Table Header View";
        self.label.textAlignment  = NSTextAlignmentCenter;
        [self addSubview:self.label];

        self.plusButton = [[UIButton alloc] init];
        [self.plusButton setTitle:@"+" forState:UIControlStateNormal];
        [self addSubview:self.plusButton];
        [self.plusButton addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];

        self.minusButton = [[UIButton alloc] init];
        [self.minusButton setTitle:@"-" forState:UIControlStateNormal];
        [self addSubview:self.minusButton];
        [self.minusButton addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];


    }

    return self;
}



- (void)updateConstraints
{
    [super updateConstraints];
    //
    // Auto Layout
    //
    NSDictionary *views = NSDictionaryOfVariableBindings(_label, _plusButton, _minusButton);

    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.minusButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.plusButton.translatesAutoresizingMaskIntoConstraints = NO;

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_minusButton]-[_label]-[_plusButton]-|" options:0 metrics:0 views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_label]" options:0 metrics:0 views:views]];


    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.minusButton
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.label
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.plusButton
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.label
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
}

#pragma mark - Actions

- (void)removeAction:(id)sender
{
    [self.delegate didDecrement];
}

- (void)addAction:(id)sender
{
    [self.delegate didIncrement];
}

@end