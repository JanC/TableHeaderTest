//
// Created by Jan Chaloupecky on 14/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "ECTableViewController.h"
#import "ECHeaderViewController.h"

NSString *const ECTableViewControllerCellId = @"ECTableViewControllerCellId";

@interface ECTableViewController() <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, assign, readwrite) BOOL calendarViewVisible;

@property(nonatomic, strong) ECHeaderViewController *headerViewController;
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


    self.headerViewController = [[ECHeaderViewController alloc] init];

    [self addChildViewController:self.headerViewController];

    self.headerViewController.view.frame = CGRectZero;
    self.headerViewController.view.clipsToBounds = YES;
    [self.view addSubview: self.self.headerViewController.view];
    [self.headerViewController didMoveToParentViewController:self];

    //
    // Calendar view is the table header view
    //
    self.headerViewController.view.frame = CGRectZero;
    self.tableView.tableHeaderView = self.headerViewController.view;
    self.tableView.tableHeaderView.frame = CGRectZero;


    //
    // Auto Layout
    //
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];

    NSDictionary *views = NSDictionaryOfVariableBindings(_tableView);
    NSDictionary *metrics = @{};

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:metrics views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:metrics views:views]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.tableHeaderView.frame = [self frameForHeaderView:YES];
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
    //
    // Before animation
    //
    [UIView animateKeyframesWithDuration:0.5 delay:0.0 options:UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  self.headerViewController.view.frame = [self frameForHeaderView:self.calendarViewVisible];
                                  self.tableView.tableHeaderView = self.headerViewController.view;
                              }
                              completion:^(BOOL finished) {
                              }];

}

-(CGRect) frameForHeaderView:(BOOL) visible
{
    CGFloat height = visible ? 100.0 : 0.0;
    CGRect headerFrame = self.headerViewController.view.frame;
    headerFrame.size.height = height;
    return headerFrame;
}

//- (void)toggleCalendarView:(id)toggleCalendarView
//{
//
//    CGRect closedFrame = CGRectMake(0, 0, self.view.frame.size.width, 0);
//    CGRect openFrame = CGRectMake(0, 0, self.view.frame.size.width, 100);
//    CGRect newFrame = self.calendarViewVisible ? openFrame : closedFrame;
//
//
//    // The UIView animation block handles the animation of our header view
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//
//    // beginUpdates and endUpdates trigger the animation of our cells
////    [self.tableView beginUpdates];
//
//
//    self.headerViewController.view.frame = newFrame;
//    [self.tableView setTableHeaderView:self.headerViewController.view];
//
////    [self.tableView endUpdates];
//    [UIView commitAnimations];
//
//    self.calendarViewVisible = !self.calendarViewVisible;
//}


@end