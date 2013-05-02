//
//  TitleFont.m
//  ChuckNorrisChallenge
//
//  Created by Thuy Copeland on 5/2/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "TitleFont.h"

@implementation TitleFont
- (void)awakeFromNib{
    UIFont *font = [UIFont fontWithName:@"GearedSlab-Extrabold" size:self.font.pointSize];
    self.font = font;
}
@end
