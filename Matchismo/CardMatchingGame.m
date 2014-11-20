//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by JingLI on 9/21/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic,readwrite)NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards; //of Card

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(NSMutableArray *)historyOfCards
{
    if(!_historyOfCards)_historyOfCards = [[NSMutableArray alloc] init];
    return _historyOfCards;
}
-(NSMutableArray *)historyOfStatus
{
    if(!_historyOfStatus)_historyOfStatus = [[NSMutableArray alloc] init];
    return _historyOfStatus;
}
-(NSMutableArray *)historyOfScore
{
    if(!_historyOfScore)_historyOfScore = [[NSMutableArray alloc] init];
    return _historyOfScore;
}
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingdeck:(Deck *)deck
{
    self = [super init];
    if(self)
    {
        for(int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if(card)
            {
                [self.cards addObject:card];
            }
            else
            {
                self = nil;
                break;
            }
        }
        self.matchMode = 2;
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count])? self.cards[index] : nil;
}

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched)
    {
        if(card.isChosen)
        {
            card.chosen = NO;
        }
        else
        {
            NSMutableArray *otherCardIndexs = [[NSMutableArray alloc] init];//of NSNumber(Card Index)
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];//of Card
            for(Card *otherCard in self.cards)
            {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    NSNumber *cardIndex = [NSNumber numberWithUnsignedInteger:[self.cards indexOfObject:otherCard]];
                    [otherCardIndexs addObject:cardIndex];
                    [otherCards addObject:otherCard];
                }
            }
            if([otherCards count] == self.matchMode - 1)
            {
                int matchScore = [card match:otherCards];
                if(matchScore)
                {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for(NSNumber *otherCardIndex in otherCardIndexs)
                    {
                        [self cardAtIndex: otherCardIndex.unsignedIntegerValue].matched = YES;
                    }
                    [self.historyOfStatus addObject:@1];
                    [self.historyOfScore addObject:[NSNumber numberWithInt:(matchScore * MATCH_BONUS)]];
                }
                else
                {
                    self.score -= MISMATCH_PENALTY;
                    for(NSNumber *otherCardIndex in otherCardIndexs)
                    {
                        [self cardAtIndex: otherCardIndex.unsignedIntegerValue].chosen = NO;
                    }
                    [self.historyOfStatus addObject:@0];
                }
                [otherCards addObject:card];
                [self.historyOfCards addObject:otherCards];
                [self.historyOfScore addObject:[NSNumber numberWithInt:MISMATCH_PENALTY]];

            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
