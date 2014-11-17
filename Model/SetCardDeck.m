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
            for(NSString *color in [SetCard validColors])
            {
                for(NSString *shading in [SetCard validShadings])
                {
                    for(NSString *shape in [SetCard validShapes])
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
