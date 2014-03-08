//
//  Movie.h
//  Movies
//
//  Created by user on 3/3/14.
//  Copyright (c) 2014 Shanthi Sivanesan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *actors;
@property (nonatomic, strong) NSString *imageURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
