//
//  ViewController.m
//  LocationReminders
//
//  Created by John D Hearn on 12/5/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "ViewController.h"
@import MapKit;
@import Parse;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    /* Useful sample code */
//    PFObject * testObject = [PFObject objectWithClassName:@"TestObject"];
//
//    testObject[@"foo"] = @"bar";
//
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        if(error) {
//            NSLog(@"%@", error.localizedDescription);
//            return;
//        }
//
//        if(succeeded) {
//            NSLog(@"Successfully saved testObject");
//        }
//    }];
//
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if(!error) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                NSLog(@"%@",objects);
//            }];
//        }
//    }];


    [self requestPermissions];
    [self.mapView setShowsUserLocation:YES];
}

-(void)requestPermissions{
    self.locationManager = [[CLLocationManager alloc] init];
    //[self setLocationManager:[[CLLocationManager alloc] init]];
    [self.locationManager requestWhenInUseAuthorization];

}

-(void)setLocationTo:(CLLocationCoordinate2D)coordinate{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [self.mapView setRegion:region animated:YES];
}


- (IBAction)slateCoffeeRoastersPressed:(id)sender {
    CLLocationCoordinate2D slateCoffee = CLLocationCoordinate2DMake(47.66114, -122.31388);
    [self setLocationTo:slateCoffee];

}
- (IBAction)laMarzoccoCafePressed:(id)sender {
    CLLocationCoordinate2D laMarzocco = CLLocationCoordinate2DMake(47.6228, -122.3551);
    [self setLocationTo:laMarzocco];
}
- (IBAction)unionCoffeePressed:(id)sender {
    CLLocationCoordinate2D unionCoffee = CLLocationCoordinate2DMake(47.61281, -122.30105);
    [self setLocationTo:unionCoffee];
}

@end
