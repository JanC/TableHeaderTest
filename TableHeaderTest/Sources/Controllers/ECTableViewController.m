//
// Created by Jan Chaloupecky on 14/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "ECTableViewController.h"
#import "ECHeaderViewController.h"
#import "ECHeaderView.h"

NSString *const ECTableViewControllerCellId = @"ECTableViewControllerCellId";

@interface ECTableViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, assign, readwrite) BOOL calendarViewVisible;


@property(nonatomic, strong) UIView *headerView;
@property(nonatomic, strong) NSLayoutConstraint *headerHeightConstraint;
@end

@implementation ECTableViewController
{
}

- (id)init
{
    self = [super init];
    if ( self )
    {
        self.title = @"NOT OK";
    }

    return self;
}

- (void)loadView
{
    [super loadView];

    //
    // Setup Table View
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ECTableViewControllerCellId];


    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(toggleCalendarView:)];



    //
    // Setup Header  View Controller 
    //


    ECHeaderViewController *headerViewController = [[ECHeaderViewController alloc] init];
    self.headerView = headerViewController.view;

    [self addChildViewController:headerViewController];
    [self.view addSubview:self.headerView];
    headerViewController.view.clipsToBounds = YES;
    [headerViewController didMoveToParentViewController:self];


    //
    // Calendar view is the table header view
    //

    //self.headerView = [[ECHeaderView alloc] init];
    self.headerView = headerViewController.view;
    //self.tableView.tableHeaderView = self.headerView;

    //
    // Auto Layout
    //
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];

    id topLayoutGuide = self.topLayoutGuide;

    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView, _headerView, topLayoutGuide);
    NSDictionary *metrics = @{};



    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_headerView]|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][_headerView][_tableView]|" options:0 metrics:metrics views:views]];


    self.headerHeightConstraint = [NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self.view addConstraint:self.headerHeightConstraint];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



#pragma mark - Protocols

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ECTableViewControllerCellId forIndexPath:indexPath];

    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Section %d", section];
}


#pragma mark - Actions
- (void)toggleCalendarView:(id)toggleCalendarView
{

    self.calendarViewVisible = !self.calendarViewVisible;

    self.headerHeightConstraint.constant = self.calendarViewVisible ? 100 : 0;

    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];

//    //
//    // Before animation
//    //
//    [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState
//                              animations:^{
//                                  self.headerView.frame = [self frameForHeaderView:self.calendarViewVisible];
//                                  self.tableView.tableHeaderView = self.headerView;
//                              }
//                              completion:^(BOOL finished) {
//                              }];

}

-(CGRect) frameForHeaderView:(BOOL) visible
{
    CGFloat height = visible ? 100.0 : 0.0;
    CGRect headerFrame = self.headerView.frame;
    headerFrame.size.height = height;
    return headerFrame;
}


@end