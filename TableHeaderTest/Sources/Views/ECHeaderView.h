//
// Created by Jan Chaloupecky on 14/05/14.
// Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ECHeaderViewDelegate
-(void) didIncrement;
-(void) didDecrement;
@end

@interface ECHeaderView : UIView

@property (nonatomic, weak, readwrite) id<ECHeaderViewDelegate> delegate;

@end