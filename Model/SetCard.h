//
//  SetCard.h
//  Matchismo
//
//  Created by JingLI on 11/12/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (nonatomic) NSUInteger number;
@property (nonatomic,strong) NSString *color;
@property (nonatomic,strong) NSString *shape;
@property (nonatomic,strong) NSString *shading;

+(NSArray *)validShapes;
+(NSArray *)validColors;
+(NSArray *)validShadings;
@end
