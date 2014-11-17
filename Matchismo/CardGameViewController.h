//
//  CardGameViewController.h
//  Matchismo
//
//  Created by JingLI on 9/15/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//
// Abstract class. Methods listed below must be implemented.

#import "Deck.h"
#import <UIKit/UIKit.h>

//protected
@interface CardGameViewController : UIViewController
-(Deck *)createDeck;// abstract

@end
