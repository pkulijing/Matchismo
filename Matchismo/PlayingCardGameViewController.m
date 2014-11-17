//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by JingLI on 11/1/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
@interface PlayingCardGameViewController ()
 
@end

@implementation PlayingCardGameViewController
-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
