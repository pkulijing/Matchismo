//
//  Card.h
//  Matchismo
//
//  Created by JingLI on 9/16/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int) match : (NSArray *)otherCards;

@end
