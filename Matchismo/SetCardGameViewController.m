//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by JingLI on 11/12/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end


@implementation SetCardGameViewController


-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}
-(void)chooseMatchMode
{
    self.game.matchMode = 3;
}

+(NSArray *)validColors //of color
{
    return @[[UIColor greenColor],[UIColor redColor],[UIColor blueColor]];
}
+(NSArray *)validShapes //of string
{
    return @[@"▲",@"●",@"◼︎"];
}
+(NSArray *)validShapings // of NSNumber
{
    return @[@1,@0.5,@0.1];
}

-(NSAttributedString *)titleForCard:(Card *)card
{
    SetCard *setCard = nil;
    if([card isKindOfClass:[SetCard class]])
    {
        setCard = (SetCard *)card;
    }
    NSString *titleContent = [[NSString alloc] init];
    for(int i = 0; i < setCard.number; i++)
    {
        titleContent = [titleContent stringByAppendingString:[SetCardGameViewController validShapes][setCard.shape - 1]];
    }
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:titleContent];
    [title setAttributes:@{NSForegroundColorAttributeName :[SetCardGameViewController validColors][setCard.color - 1]} range:NSMakeRange(0,title.length)];
    return title;
    
}
-(UIImage *)backgroundImageForCard:(Card *)card
{
    return (card.isChosen) ? [UIImage imageNamed:@"cardFront"] :[UIImage imageNamed:@"cardBack"];
}

-(void)updateHistory
{
    NSMutableAttributedString *historyContent = [[NSMutableAttributedString alloc] initWithString:@""];
    for(int i = 0; i < self.game.historyOfStatus.count; i++)
    {
        NSNumber *status = (NSNumber *)self.game.historyOfStatus[i];
        NSArray *cards = (NSMutableArray *)self.game.historyOfCards[i];
        NSNumber *stepScore = (NSNumber *)self.game.historyOfScore[i];
        if(status.intValue == 1)
        {
            [historyContent appendAttributedString:[[NSAttributedString alloc] initWithString:@"Found set: "]];
            for(id card in cards)
            {
                if([card isKindOfClass:[SetCard class]])
                {
                    SetCard *setCard = (SetCard *)card;
                    [historyContent appendAttributedString:[self titleForCard:setCard]];
                }
                [historyContent appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" for %d points.",stepScore.intValue]]];
            }
        }
        else
        {
            for(id card in cards)
            {
                if([card isKindOfClass:[SetCard class]])
                {
                    SetCard *setCard = (SetCard *)card;
                    [historyContent appendAttributedString:[self titleForCard:setCard]];
                }
                [historyContent appendAttributedString:[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" do not match. %d points penalty.",stepScore.intValue]]];
            }
        }
    }
    self.historyString = historyContent;
}


















@end
