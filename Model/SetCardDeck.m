//
//  SetCardDeck.m
//  Matchismo
//
//  Created by JingLI on 11/12/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck
-(instancetype)init
{
    self = [super init];
    if(self)
    {
        for(NSUInteger number = 1; number <= 3; number++)
        {
            for(NSUInteger color = 1; color <= 3; color++)
            {
                for(NSUInteger shading = 1; shading <= 3; shading++)
                {
                    for(NSUInteger shape  = 1; shape <= 3; shape++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.color = color;
                        card.shading = shading;
                        card.shape = shape;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}
@end
