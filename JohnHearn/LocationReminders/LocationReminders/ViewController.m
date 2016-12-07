//
//  ViewController.m
//  LocationReminders
//
//  Created by John D Hearn on 12/5/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "LocationController.h"
#import "Reminder.h"
//@import UIKit;
@import MapKit;
@import Parse;


@interface ViewController ()<MKMapViewDelegate, LocationControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableDictionary *coffeeShops;


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


    Reminder *testReminder = [Reminder object];
    testReminder.title = @"New Reminder";
    [testReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"%@", error.localizedDescription);
        }
        if(succeeded) {
            NSLog(@"Check your Parse dashboard");
        }
    }];



    [self requestPermissions];
    self.mapView.delegate = self;
    [LocationController sharedController].delegate =self;
    [self.mapView setShowsUserLocation:YES];

    self.coffeeShops = [[NSMutableDictionary alloc] init];
    [self loadCoffeeShopAnnotations];


}

-(void)loadCoffeeShopAnnotations{
    [self.coffeeShops setValue:[self annotate:@"Slate Coffee Roasters"
                                           at:CLLocationCoordinate2DMake(47.66114, -122.31388)]
                        forKey:@"slateCoffee"];

    [self.coffeeShops setValue:[self annotate:@"La Marzocco Cafe"
                                           at:CLLocationCoordinate2DMake(47.6228, -122.3551)]
                        forKey:@"laMarzocco"];

    [self.coffeeShops setValue:[self annotate:@"Union Coffee"
                                           at:CLLocationCoordinate2DMake(47.61281, -122.30105)]
                        forKey:@"unionCoffee"];

    [self.coffeeShops setValue:[self annotate:@"Victrola Coffee"
                                           at:CLLocationCoordinate2DMake(47.6224, -122.3128)]
                        forKey:@"victrola"];
    [self.coffeeShops setValue:[self annotate:@"Stumptown Coffee Roasters"
                                           at:CLLocationCoordinate2DMake(47.61205, -122.3170)]
                        forKey:@"stumptown"];

}

-(MKPointAnnotation *)annotate:(NSString *)title at:(CLLocationCoordinate2D)coordinate{
    MKPointAnnotation *newMapPoint = [[MKPointAnnotation alloc] init];
    newMapPoint.title = title;
    newMapPoint.coordinate = coordinate;

    [self.mapView addAnnotation:newMapPoint];
    return newMapPoint;
}

-(UIColor *)randomColor{


    CGFloat hue = ( arc4random_uniform(256) / 256.0  );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random_uniform(128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random_uniform(128) / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

    return color;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [[[LocationController sharedController] manager] startUpdatingLocation];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(reminderCreatedNotificationFired)
                                                name:@"ReminderCreated"
                                               object:nil];
}

-(void)reminderCreatedNotificationFired{
    NSLog(@"Reminder was created. NSLog fired from %@.", self);
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"ReminderCreated"
                                                  object:nil];

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
    [self setLocationTo:[[self.coffeeShops objectForKey:@"slateCoffee"] coordinate]];
}
- (IBAction)laMarzoccoCafePressed:(id)sender {
    [self setLocationTo:[[self.coffeeShops objectForKey:@"laMarzocco"] coordinate]];
}
- (IBAction)unionCoffeePressed:(id)sender {
    [self setLocationTo:[[self.coffeeShops objectForKey:@"unionCoffee"] coordinate]];
}

- (IBAction)mapLongPressed:(UILongPressGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self.mapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint
                                                          toCoordinateFromView:self.mapView];
        [self.mapView addAnnotation:[self annotate:@"New Location" at:touchMapCoordinate]];
    }
}


//MARK: LocationControllerDelegate Methods
-(void)locationControllerUpdatedLocation:(CLLocation *)location{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500);
    [self.mapView setRegion:region];

}


//MARK: MKMapViewDelegate Methods
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
    annotationView.annotation = annotation;

    if(!annotationView){
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    }

    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;

    UIButton *rightCalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

    annotationView.rightCalloutAccessoryView = rightCalloutButton;

    annotationView.pinTintColor = [self randomColor];

    //TODO: call method for random color for pin color (you want pin tint color)
    
    return annotationView;

}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
    //pass sender to prepareforsegue so we can do stuff
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
    if ([segue.identifier isEqualToString:@"DetailViewController"]){
        if([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotationView = (MKAnnotationView *)sender;

            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            detailViewController.annotationTitle = annotationView.annotation.title;
            detailViewController.coordinate = annotationView.annotation.coordinate;

            __weak typeof(self) bruceBanner = self;

            detailViewController.completion = ^(MKCircle *circle){
                __strong typeof(bruceBanner) hulk = bruceBanner;

                //[hulk.mapView removeAnnotation:annotationView.annotation];
                [hulk.mapView addOverlay:circle];
            };
        }
    }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithCircle:overlay];
    renderer.fillColor = [UIColor blueColor];
    //renderer.strokeColor = [UIColor purpleColor];

    renderer.alpha = 0.5;

    return renderer;
}
@end




