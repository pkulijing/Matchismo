//
//  PlayingCard.h
//  Matchismo
//
//  Created by JingLI on 9/16/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;

@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;

+(NSUInteger)maxRank;

@end
