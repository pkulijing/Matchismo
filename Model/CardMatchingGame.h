//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by JingLI on 9/21/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingdeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) int score;
@property (nonatomic)int matchMode;
@property (nonatomic)NSMutableArray *historyOfCards;
@property (nonatomic)NSMutableArray *historyOfStatus;
@property (nonatomic)NSMutableArray *historyOfScore;
@end
