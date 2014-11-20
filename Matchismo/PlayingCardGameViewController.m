//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by JingLI on 11/1/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@interface PlayingCardGameViewController ()
 
@end

@implementation PlayingCardGameViewController
-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

-(void)chooseMatchMode
{
    self.game.matchMode = 2;
}
-(NSAttributedString *)titleForCard:(Card *)card
{
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.contents attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    return (card.isChosen) ? title : [[NSAttributedString alloc] init];
}
-(UIImage *)backgroundImageForCard:(Card *)card
{
    return (card.isChosen) ? [UIImage imageNamed:@"cardFront"] :[UIImage imageNamed:@"cardBack"];
}

-(void)updateHistory
{
    NSMutableString *historyContent = [[NSMutableString alloc] initWithString:@""];
    for(int i = 0; i < self.game.historyOfStatus.count; i++)
    {
        NSNumber *status = (NSNumber *)self.game.historyOfStatus[i];
        NSArray *cards = (NSMutableArray *)self.game.historyOfCards[i];
        NSNumber *stepScore = (NSNumber *)self.game.historyOfScore[i];
        if(status.intValue == 1)
        {
            [historyContent appendString:@"Matched "];
            for(id card in cards)
            {
                if([card isKindOfClass:[PlayingCard class]])
                {
                    PlayingCard *playingCard = (PlayingCard *)card;
                    [historyContent appendString:playingCard.contents];
                }
            }
            [historyContent appendString:[NSString stringWithFormat:@" for %d points.\n",stepScore.intValue]];
        }
        else
        {
            for(id card in cards)
            {
                if([card isKindOfClass:[PlayingCard class]])
                {
                    PlayingCard *playingCard = (PlayingCard *)card;
                    [historyContent appendString:playingCard.contents];
                }
            }
            [historyContent appendString:[NSString stringWithFormat:@" do not match. %d points penalty.\n",stepScore.intValue]];
        }
    }
    self.historyString = [[NSMutableAttributedString alloc] initWithString:historyContent attributes:@{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]}];
}



@end
