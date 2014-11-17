//
//  Deck.h
//  Matchismo
//
//  Created by JingLI on 9/16/14.
//  Copyright (c) 2014 Yuanpei College, Peking University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *)card atTop:(BOOL)atTop;
-(void) addCard:(Card *)card;
-(Card *)drawRandomCard;

@end
