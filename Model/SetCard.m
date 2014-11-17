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
+(NSArray *)validShapes
{
    return @[@"▲",@"◼︎",@"●"];
}

+(NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+(NSArray *)validShadings
{
    return @[@"solid",@"striped",@"open"];
}

-(NSString *)contents
{
    return nil;
}

-(void)setColor:(NSString *)color
{
    if([[SetCard validColors] containsObject:color])
    {
        _color = color;
    }
}
-(void)setShading:(NSString *)shading
{
    if([[SetCard validShadings] containsObject:shading])
    {
        _shading = shading;
    }
}
-(void)setShape:(NSString *)shape
{
    if([[SetCard validShapes] containsObject:shape])
    {
        _shape = shape;
    }
}
-(NSString *)color
{
    return _color ? _color : @"?";
}
-(NSString *)shape
{
    return _shape ? _shape : @"?";
}
-(NSString *)shading
{
    return _shading ? _shading : @"?";
}
-(void)setNumber:(NSUInteger)number
{
    if(number > 0 && number < 4)
    {
        _number = number;
    }
}

+(BOOL)compareThreeStrings:(NSString *)string1 second:(NSString *)string2 third:(NSString *)string3
{
    BOOL compare12 = [string1 isEqualToString:string2];
    BOOL compare13 = [string1 isEqualToString:string3];
    BOOL compare23 = [string2 isEqualToString:string3];
    return (compare12 == compare13 && compare12 == compare23);
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
            if([SetCard compareThreeStrings:otherCard1.color second:otherCard2.color third:self.color]
            && [SetCard compareThreeStrings:otherCard1.shape second:otherCard2.shape third:self.shape]
            && [SetCard compareThreeStrings:otherCard1.shading second:otherCard2.shading third:self.shading]
            && [SetCard compareThreeNumbers:self.number second:otherCard1.number third:otherCard2.number])
            {
                score += 50;
            }
        }
    }
    return score;
}






























@end
