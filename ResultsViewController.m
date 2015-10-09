//
//  ResultsViewController.m
//  CloseToHomeApp
//
//  Created by Asher Rosenblatt on 8/6/15.
//  Copyright (c) 2015 Asher Rosenblatt. All rights reserved.
//

#import "ResultsViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ResultsViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *storyTextView;
@property (weak, nonatomic) IBOutlet MKMapView *resultsMapView;

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.quillStory dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    
    UIFont *font = [UIFont fontWithName:@"Arial" size:17.0];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:attributedString.string attributes:attrsDictionary];
    
    
    
    self.storyTextView.attributedText = attrString;
    
    
    for (NSDictionary *place in self.placesDictionary[@"parks"]) {
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        NSString *addressString = [NSString stringWithFormat:@"%@ %@ %@", place[@"name"],place[@"street_address"], place[@"zip"]];
        [geocoder geocodeAddressString:addressString completionHandler:^(NSArray *placemarks, NSError *error) {
            MKPlacemark *thing = [[MKPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
            [self.resultsMapView addAnnotation:thing];
            [self.resultsMapView setCenterCoordinate:thing.coordinate animated:YES];
        }];
    }
    
}


@end

