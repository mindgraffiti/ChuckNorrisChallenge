//
//  BodyFont.m
//  ChuckNorrisChallenge
//
//  Created by Thuy Copeland on 5/2/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "BodyFont.h"

@implementation BodyFont

- (void)awakeFromNib{
    UIFont *font = [UIFont fontWithName:@"GearedSlab-Thin" size:self.font.pointSize];
    self.font = font;
}

@end
