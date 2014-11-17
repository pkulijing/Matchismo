//
//  PlayingCard.m
//  Matchismo
//
//  Created by JingLI on 9/16/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

-(NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSArray *)validSuits
{
    return @[@"♣️",@"♥️",@"♦️",@"♠️"];
}

-(void) setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank])
        _rank = rank;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if( otherCards.count == 1)
    {
        id card = [otherCards firstObject];
        if([card isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *otherCard = (PlayingCard *)card;
            if([self.suit isEqualToString:otherCard.suit])
                score += 1;
            else if(self.rank == otherCard.rank)
                score += 4;
        }
    }
    else if(otherCards.count == 2)
    {
        id card1 = [otherCards firstObject];
        id card2 = [otherCards lastObject];
        if([card1 isKindOfClass:[PlayingCard class]] && [card2 isKindOfClass:[PlayingCard class]])
        {
            PlayingCard *otherCard1 = (PlayingCard *)card1;
            PlayingCard *otherCard2 = (PlayingCard *)card2;
            if(self.rank == otherCard1.rank && self.rank == otherCard2.rank)
                score += 200;
            else if(self.suit == otherCard1.suit && self.suit == otherCard2.suit)
                score += 50;
            else
            {
                score += [self match:@[otherCard1]];
                score += [self match:@[otherCard2]];
                score += [otherCard1 match:@[otherCard2]];
            }
        }
    }
    return score;
    
}















@end
