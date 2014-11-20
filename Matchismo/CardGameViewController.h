//
//  CardGameViewController.h
//  Matchismo
//
//  Created by JingLI on 9/15/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved./Users/jingli/Developer/IOSdev/Matchismo/Matchismo/CardGameViewController.h
//
// Abstract class. Methods listed below must be implemented.

#import "Deck.h"
#import "CardMatchingGame.h"
#import <UIKit/UIKit.h>

//protected
@interface CardGameViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong,nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong,nonatomic) NSMutableAttributedString *historyString;

//virtual methods
-(void)chooseMatchMode;
-(void)updateHistory;
-(Deck *)createDeck;
-(NSAttributedString *)titleForCard:(Card *)card;
-(UIImage *)backgroundImageForCard:(Card *)card;

@end
