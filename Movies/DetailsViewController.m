//
//  DetailsViewController.m
//  Movies
//
//  Created by user on 3/3/14.
//  Copyright (c) 2014 Shanthi Sivanesan. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorsLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;

@end

@implementation DetailsViewController

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
	self.titleLabel.text = self.movie.title;
    self.ratingLabel.text = self.movie.rating;
    self.actorsLabel.text = self.movie.actors;
    self.synopsisLabel.text = self.movie.synopsis;
    
    NSURL *url = [NSURL URLWithString:self.movie.imageURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.posterImage.image = [UIImage imageWithData:data];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
