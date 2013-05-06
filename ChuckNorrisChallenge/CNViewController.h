//
//  CNViewController.h
//  ChuckNorrisChallenge
//
//  Created by Thuy Copeland on 5/2/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNViewController : UIViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *jokeLabel;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeft;
- (void) screenSwipedLeft:(UIGestureRecognizer *)recognizer;

- (IBAction)refreshButtonPressed:(id)sender;
@end
