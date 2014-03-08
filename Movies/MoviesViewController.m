//
//  MoviesViewController.m
//  Movies
//
//  Created by user on 3/3/14.
//  Copyright (c) 2014 Shanthi Sivanesan. All rights reserved.
//

#import "MoviesViewController.h"
#import "Movie.h"
#import "DetailsViewController.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSArray *movies;

@end

@implementation MoviesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refresh];
    
    [self.refreshControl addTarget:self action:@selector(refresh2) forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MovieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Movie *movie = self.movies[indexPath.row];
    cell.textLabel.text = movie.title;
    cell.detailTextLabel.text = movie.synopsis;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"movie"]) {
        DetailsViewController *controller = (DetailsViewController *)segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.movie = self.movies[indexPath.row];
    }
}

- (void)refresh {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Connection error: %@", connectionError);
        } else {
            NSError *error = nil;
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            //NSLog(@"%@", object);
            if (error) {
                NSLog(@"JSON parsing error: %@", error);
            } else {
                NSDictionary *dictionary = (NSDictionary *)object;
                NSMutableArray *newMovies = [NSMutableArray array];
                for (NSDictionary *params in [dictionary objectForKey:@"movies"]) {
                    Movie *movie = [[Movie alloc] initWithDictionary:params];
                    [newMovies addObject:movie];
                }
                self.movies = newMovies;
                //[self.refreshControl endRefreshing];
                [self.tableView reloadData];
            }
        }
    }];
    
}

- (void)refresh2 {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"Connection error: %@", connectionError);
        } else {
            NSError *error = nil;
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            //NSLog(@"%@", object);
            if (error) {
                NSLog(@"JSON parsing error: %@", error);
            } else {
                NSDictionary *dictionary = (NSDictionary *)object;
                NSMutableArray *newMovies = [NSMutableArray array];
                for (NSDictionary *params in [dictionary objectForKey:@"movies"]) {
                    Movie *movie = [[Movie alloc] initWithDictionary:params];
                    [newMovies addObject:movie];
                }
                self.movies = newMovies;
                [self.refreshControl endRefreshing];
                [self.tableView reloadData];
            }
        }
    }];
    
}
@end
