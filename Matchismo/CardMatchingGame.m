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

-(NSMutableArray *)historyMessages
{
    if(!_historyMessages)_historyMessages = [[NSMutableArray alloc] init];
    return _historyMessages;
}
-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(BOOL)checkLeftMatch
{
    for(Card *card in self.cards)
    {
        if(card.isMatched)continue;
        for(Card *otherCard in self.cards)
        {
            if([self.cards indexOfObject:card] == [self.cards indexOfObject:otherCard] ||
               otherCard.isMatched)
                continue;
            if([card match:@[otherCard]])
                return YES;
        }
    }
    return NO;
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
        NSString *message = [[NSString alloc] init];
        if(card.isChosen)
        {
            card.chosen = NO;
            for(Card *otherCard in self.cards)
            {
                if(otherCard.isChosen && !otherCard.isMatched)
                {
                    message = [message stringByAppendingString:otherCard.contents];
                }
            }
            [self.historyMessages addObject:message];
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
                    message = [message stringByAppendingString:otherCard.contents];
                }
            }
            message = [message stringByAppendingString:card.contents];
            if([otherCardIndexs count] == self.matchMode - 1)
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
                    NSString *tempMessage = @"Matched ";
                    tempMessage = [tempMessage stringByAppendingString:message];
                    tempMessage = [tempMessage stringByAppendingString:
                                   [NSString stringWithFormat:@" for %d points",matchScore*MATCH_BONUS]];
                    message = tempMessage;
                }
                else
                {
                    self.score -= MISMATCH_PENALTY;
                    for(NSNumber *otherCardIndex in otherCardIndexs)
                    {
                        [self cardAtIndex: otherCardIndex.unsignedIntegerValue].chosen = NO;
                    }
                    message = [message stringByAppendingString:[NSString stringWithFormat:@" don't match. %d points penalty!",MISMATCH_PENALTY]];
                }

            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            [self.historyMessages addObject:message];
           // NSLog(@"count: %d\n",self.historyMessages.count);
        }
    }
}

@end
