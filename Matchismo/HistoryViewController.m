//
//  HistoryViewController.m
//  Matchismo
//
//  Created by JingLI on 11/18/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end

@implementation HistoryViewController


-(NSMutableAttributedString *)history
{
    if(!_history)
        _history = [[NSMutableAttributedString alloc] init];
    return _history;
}

-(void)updateUI
{
    self.historyTextView.attributedText = self.history;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

@end
