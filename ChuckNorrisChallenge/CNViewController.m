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
    //[AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/plain"]];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    self.title = @"Chuck Norris Joke Challenge";
    self.jokeLabel.text = @"View did load, testing text";
    [self displayARandomJoke];
}

// add a little AFNetworking magic to grab a random joke
- (void)randomJoke:(id)JSON{
    
    // create a dictionary to store Chuck Norris data
    NSDictionary *root = (NSDictionary *)JSON;
    // drill down into first object
    NSDictionary *results = [root valueForKey:@"value"];
    // grab the first pair
    for (NSDictionary *row in results) {
        id joke = [row valueForKey:@"joke"];
        self.jokeLabel.text = @"Test this text";
        //[NSString stringWithFormat:@"%@",joke];
        NSLog(@"%@", joke);
    }
}

- (void)displayARandomJoke{
    // set up the random joke URL
    NSString *randomURL = [NSString stringWithFormat:@"http://api.icndb.com/jokes/random"];
    // encode special chars
    NSString *encodedURL = [randomURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // save the encoded url
    NSURL *url = [NSURL URLWithString:encodedURL];
    // full request URL
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    // Make a request to GET the JSON data.
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // create a dictionary to store Chuck Norris data
        NSDictionary *root = (NSDictionary *)JSON;
        // drill down into first object
        NSDictionary *results = [root valueForKey:@"value"];
        // grab the first pair
        for (NSDictionary *row in results) {
            id joke = [row valueForKey:@"joke"];
            self.jokeLabel.text = @"Test this text";
            //[NSString stringWithFormat:@"%@",joke];
            NSLog(@"%@", joke);
        }

        // save the joke and put it in the jokeLabel
        // NSArray *aJoke = [joke lastObject];
    }
                                         
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
