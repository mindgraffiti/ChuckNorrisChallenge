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

@end

NSString *const FlickrAPIKey = @"d0295072c7a217e8c8e9f4805e6439c5";
// ac8632f586ffdd791cf9af3fffecb90c

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
    self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwipedLeft:)];
    
    [self.swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:self.swipeLeft];
    
    [self displayJokeImage];
    [self displayARandomJoke];
}

- (void)screenSwipedLeft:(UIGestureRecognizer *)recognizer
{
    NSLog(@"screen was swiped left");
    [self displayARandomJoke];
}

- (void)displayJokeImage{
    self.randomNum = arc4random_uniform(7);
    //self.randomNum = 3;
    UIImage *image = [UIImage imageNamed:@"0.jpg"];
    //NSLog(@"%d.jpg", self.randomNum);
    self.imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:self.imageView];
    self.imageView.center = self.scrollView.center;
    
    /*
    NSURL *picURL = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=chuck+norris&per_page=1&format=json&nojsoncallback=1&auth_token=72157633433724510-00bda4b4f1dd472d&api_sig=e882c850f29a3f76a35af6803e6c30ab", FlickrAPIKey];
    
    NSURLRequest *requestImage = [NSURLRequest requestWithURL:picURL];
    NSLog(@"about to load image");
    
    AFImageRequestOperation *operationImage = [AFImageRequestOperation imageRequestOperationWithRequest:requestImage success:^(UIImage *flickrPic){
        self.imageView = [[UIImageView alloc] initWithImage:self.flickrPic];
        [self.view addSubview:self.imageView];
        self.imageView.center = self.scrollView.center;

        NSLog(@"image loaded");
    }];
    [operationImage start];
     */
}

- (void)randomImage{
    /*
    // create a dictionary to store Chuck Norris data
    NSDictionary *root = (NSDictionary *)flickrPic;
    // drill down into first object
    NSDictionary *results = [root valueForKey:@"photos"];
    NSLog(@"%@", results);
    // grab the first pair
    NSDictionary *photo = [root valueForKey:@"photo"];
    NSDictionary *owner = [photo valueForKey:@"owner"];
    NSDictionary *picID = [photo valueForKey:@"id"];
    NSLog(@"owner: %@, picID: %@", owner, picID);
    */
    
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
