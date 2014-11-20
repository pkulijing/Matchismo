//
//  SetCard.m
//  Matchismo
//
//  Created by JingLI on 11/12/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
@synthesize color = _color;
@synthesize shape = _shape;
@synthesize shading = _shading;


-(NSString *)contents
{
    return nil;
}

-(void)setNumber:(NSUInteger)number
{
    if(number > 0 && number < 4) _number = number;
}

-(void)setColor:(NSUInteger)color
{
    if(color > 0 && color < 4) _color = color;
}

-(void)setShape:(NSUInteger)shape
{
    if(shape > 0 && shape < 4) _shape = shape;
}

-(void)setShading:(NSUInteger)shading
{
    if(shading > 0 && shading < 4) _shading = shading;
}
+(BOOL)compareThreeNumbers:(NSUInteger)num1 second:(NSUInteger)num2 third:(NSUInteger)num3
{
    BOOL compare12 = (num1 == num2);
    BOOL compare13 = (num1 == num3);
    BOOL compare23 = (num2 == num3);
    return (compare12 == compare13 && compare12 == compare23);
}
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if(otherCards.count == 2)
    {
        id card1 = [otherCards firstObject];
        id card2 = [otherCards lastObject];
        if([card1 isKindOfClass:[SetCard class]] && [card2 isKindOfClass:[SetCard class]])
        {
            SetCard *otherCard1 = (SetCard *)card1;
            SetCard *otherCard2 = (SetCard *)card2;
            if([SetCard compareThreeNumbers:otherCard1.color second:otherCard2.color third:self.color]
            && [SetCard compareThreeNumbers:otherCard1.shape second:otherCard2.shape third:self.shape]
            && [SetCard compareThreeNumbers:otherCard1.shading second:otherCard2.shading third:self.shading]
            && [SetCard compareThreeNumbers:self.number second:otherCard1.number third:otherCard2.number])
            {
                score += 50;
            }
        }
    }
    return score;
}






























@end
