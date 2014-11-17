//
//  CardGameViewController.m
//  Matchismo
//
//  Created by JingLI on 9/15/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchModeControl;
@property (weak, nonatomic) IBOutlet UISlider *historyDisplay;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if(!_game)_game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                       usingdeck:[self createDeck]];
    return _game;
}
- (Deck *)createDeck // abstract
{
    return nil;
}

- (IBAction)historySlider:(UISlider *)sender
{
    [self updateUI]; 
}

-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
    }
    if(![self.game checkLeftMatch])
    {
        for(UIButton *cardButton in self.cardButtons)
        {
            cardButton.enabled = NO;
            self.scoreLabel.text = [NSString stringWithFormat:@"Final score: %ld",self.game.score];
        }
    }
    if(self.game.matchMode == 2)
    {
        self.matchModeControl.selectedSegmentIndex = 0;
    }
    else if(self.game.matchMode == 3)
    {
        self.matchModeControl.selectedSegmentIndex = 1;
    }
    if(self.game.historyMessages.count)
    {
        NSUInteger num = self.historyDisplay.value * (self.game.historyMessages.count - 1);
        if(num != self.game.historyMessages.count - 1)
        {
            self.historyDisplay.alpha  = 0.5;
            self.messageLabel.alpha = 0.5;
        }
        else
        {
            self.historyDisplay.alpha = 1;
            self.messageLabel.alpha = 1;
        }
        self.messageLabel.text = self.game.historyMessages[num];
    }
    else
    {
        self.messageLabel.text = @"";
    }
}
- (IBAction)redealButton:(UIButton *)sender
{
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingdeck:[self createDeck]];
    self.matchModeControl.enabled = YES;
    self.historyDisplay.value = 1;
    [self updateUI];
}

- (IBAction)matchModeSwitch:(UISegmentedControl *)sender
{
    if(sender.isEnabled)
    {
        if(sender.selectedSegmentIndex == 0)
        {
            self.game.matchMode = 2;
        }
        else if(sender.selectedSegmentIndex == 1)
        {
            self.game.matchMode = 3;
        }
       // NSLog(@"match mode = %d",self.game.matchMode);
    }
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if(self.matchModeControl.isEnabled)
    {
        self.matchModeControl.enabled = NO;
    }
    NSUInteger chooseButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];
    self.historyDisplay.value = 1;
    [self updateUI];
}

-(NSString *)titleForCard:(Card *)card
{
    return (card.isChosen) ? card.contents : @"";
}
-(UIImage *)backgroundImageForCard:(Card *)card
{
    return (card.isChosen) ? [UIImage imageNamed:@"cardFront"] :[UIImage imageNamed:@"cardBack"];
}

@end
