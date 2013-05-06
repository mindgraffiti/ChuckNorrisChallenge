//
//  CNViewController.m
//  ChuckNorrisChallenge
//
//  Created by Thuy Copeland on 5/2/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "CNViewController.h"
#import "AFNetworking/AFNetworking.h"

@interface CNViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *jokeLabel;
@property (strong, nonatomic) UISwipeGestureRecognizer *oneFingerSwipeRight;

- (IBAction)refreshButtonPressed:(id)sender;
@end

@implementation CNViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add another acceptable content type
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    self.title = @"Chuck Norris Joke Challenge";
    self.jokeLabel.text = @"Loading...";
    
    // add swipe gestures
    self.oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedRight:)];
    self.oneFingerSwipeRight.numberOfTouchesRequired = 1;
    [self.oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:self.oneFingerSwipeRight];
    
    [self displayJokeImage];
    [self displayARandomJoke];
}

- (void)screenSwipedRight:(UITapGestureRecognizer *)recognizer
{
    [self displayARandomJoke];
}


- (void)displayJokeImage{
    UIImage *image = [UIImage imageNamed:@"chucknorris.jpg"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:self.imageView];
    
    // 1. measure the size of the image
    CGSize size = self.imageView.frame.size;
    // 2. set the content size based on the image
    self.scrollView.contentSize = size;
    self.scrollView.contentOffset = CGPointMake(300, 300);

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

// add a little AFNetworking magic to grab a random joke
- (void)randomJoke:(id)JSON{
    // create a dictionary to store Chuck Norris data
    NSDictionary *root = (NSDictionary *)JSON;
    // drill down into first object
    NSDictionary *results = [root valueForKey:@"type"];
    NSLog(@"%@", results);
    // grab the first pair
    NSDictionary *joke = [[root valueForKey:@"value"] valueForKey:@"joke"];
    NSLog(@"%@", joke);
    self.jokeLabel.text = [NSString stringWithFormat:@"%@",joke];
}

- (void)displayARandomJoke{
    // set up the random joke URL
    NSString *randomURL = [NSString stringWithFormat:@"http://api.icndb.com/jokes/random/"];
    // encode special chars
    NSString *encodedURL = [randomURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // save the encoded url
    NSURL *url = [NSURL URLWithString:encodedURL];
    // full request URL
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    // Make a request to GET the JSON data.
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self randomJoke:JSON];
    }
                                         
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];

}

- (IBAction)refreshButtonPressed:(id)sender{
    [self displayARandomJoke];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
