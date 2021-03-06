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
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *flickrPic;
@property (weak, nonatomic) IBOutlet UILabel *jokeLabel;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeft;
@property (assign, nonatomic) int randomNum;

- (void) screenSwipedLeft:(UIGestureRecognizer *)recognizer;
- (IBAction)refreshButtonPressed:(id)sender;
@end
