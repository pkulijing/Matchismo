//
//  CardGameViewController.m
//  Matchismo
//
//  Created by JingLI on 9/15/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"

@interface CardGameViewController ()
@end

@implementation CardGameViewController

-(NSMutableAttributedString *)historyString
{
    if(!_historyString)
        _historyString = [[NSMutableAttributedString alloc] init];
    return _historyString;
}

-(CardMatchingGame *)game
{
    if(!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingdeck:[self createDeck]];
    [self chooseMatchMode];
    return _game;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showHistory"])
    {
        if([segue.destinationViewController isKindOfClass:[HistoryViewController class]])
        {
            HistoryViewController *historyVC = (HistoryViewController *)segue.destinationViewController;
            [self updateHistory];
            historyVC.history = self.historyString;
        }
    }
}

-(void)chooseMatchMode{}
-(void)updateHistory{}
-(Deck *)createDeck{return nil;}
-(NSString *)titleForCard:(Card *)card{return nil;}
-(UIImage *)backgroundImageForCard:(Card *)card{return nil;}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (IBAction)redealButton:(UIButton *)sender
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingdeck:[self createDeck]];
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{

    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    [self updateUI];
}


@end
