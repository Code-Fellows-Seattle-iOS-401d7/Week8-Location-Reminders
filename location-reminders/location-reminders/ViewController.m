//
//  ViewController.m
//  location-reminders
//
//  Created by Corey Malek on 12/5/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//
@import MapKit;

#import "ViewController.h"

#import <Parse/Parse.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(strong, nonatomic) CLLocationManager *locationManager;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestPermissions];
    [self.mapView setShowsUserLocation:YES];
}



-(void)requestPermissions{
    
    [self setLocationManager:[[CLLocationManager alloc]init]];
    [self.locationManager requestWhenInUseAuthorization];
}

- (IBAction)setLocationPressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6566, -122.351096);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [self.mapView setRegion:region animated:YES];
    
    
}
- (IBAction)locationOnePressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(36.155641, -115.331964);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 750, 1000);
    [self.mapView setRegion:region animated:YES];
}


- (IBAction)locationTwoPressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(42.688062, -73.852369);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);
    [self.mapView setRegion:region animated:YES];
}


- (IBAction)locationThreePressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.612293, -122.336288);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 750, 750);
    [self.mapView setRegion:region animated:YES];
}


//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];

       
//
//    testObject[@"foo"] = @"bar";
//    
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error){
//        
//        if(error) {
//            NSLog(@"%@", error.localizedDescription);
//            return;
//        }
//        
//        if(succeeded) {
//            NSLog(@"Successfully saved testObject");
//        }
//        
//    }];
    






@end
