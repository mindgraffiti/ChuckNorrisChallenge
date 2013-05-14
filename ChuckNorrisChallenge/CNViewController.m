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

NSString *const FlickrAPIKey = @"ac8632f586ffdd791cf9af3fffecb90c";
NSString *word = @"chuck+norris";

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
    [self displayJokeImage];
}

- (void)displayJokeImage{
    self.randomNum = arc4random_uniform(100);
    NSString *imageString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=chuck+norris&per_page=1&page=%d&size=m&format=json&nojsoncallback=1",FlickrAPIKey,self.randomNum];
    
    NSURL *url = [NSURL URLWithString:imageString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [self randomImage:JSON];
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error on display random image");
        }];
    [operation start];
}

- (void)randomImage:(id)JSON{
    NSDictionary *results = (NSDictionary *) JSON;
    NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    for (NSDictionary *photo in photos){
        NSString *photoURLString =
        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        NSLog(@"photoURLString: %@", photoURLString);
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:photoURLString]];
        self.imageView.image = [UIImage imageWithData:imageData];
    }
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
        NSLog(@"Error on display random joke: %@", error);
    }];
    [operation start];

}

- (IBAction)refreshButtonPressed:(id)sender{
    [self displayARandomJoke];
    [self displayJokeImage];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
