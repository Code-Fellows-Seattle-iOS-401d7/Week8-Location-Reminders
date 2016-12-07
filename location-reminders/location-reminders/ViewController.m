//
//  ViewController.m
//  location-reminders
//
//  Created by Corey Malek on 12/5/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "LocationController.h"

#import <Parse/Parse.h>

@import MapKit;

@interface ViewController ()<MKMapViewDelegate, LocationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(strong, nonatomic) CLLocationManager *locationManager;

@property(strong, nonatomic) UIColor *pinTintColor;

@property(strong, nonatomic) NSArray *colorArray;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestPermissions];
    
    self.mapView.delegate = self;
    [LocationController sharedController].delegate = self;

    [self.mapView setShowsUserLocation:YES];
    
    //5 default pins go here
    //first:
    MKPointAnnotation *defaultPoint1 = [[MKPointAnnotation alloc]init];
    defaultPoint1.title = @"LA";
    defaultPoint1.coordinate = CLLocationCoordinate2DMake(34.052235, -118.243683);
    [self.mapView addAnnotation:defaultPoint1];
    
    //second:
    MKPointAnnotation *defaultPoint2 = [[MKPointAnnotation alloc]init];
    defaultPoint2.title = @"San Fran";
    defaultPoint2.coordinate = CLLocationCoordinate2DMake(37.733795, -122.446747);
    [self.mapView addAnnotation:defaultPoint2];
    
    //third:
    MKPointAnnotation *defaultPoint3 = [[MKPointAnnotation alloc]init];
    defaultPoint3.title = @"Portland";
    defaultPoint3.coordinate = CLLocationCoordinate2DMake(45.523064, -122.676483);
    [self.mapView addAnnotation:defaultPoint3];
    
    //fourth:
    MKPointAnnotation *defaultPoint4 = [[MKPointAnnotation alloc]init];
    defaultPoint4.title = @"San Diego";
    defaultPoint4.coordinate = CLLocationCoordinate2DMake(32.715736, -117.161087);
    [self.mapView addAnnotation:defaultPoint4];
    
    //fifth:
    MKPointAnnotation *defaultPoint5 = [[MKPointAnnotation alloc]init];
    defaultPoint5.title = @"Zion";
    defaultPoint5.coordinate = CLLocationCoordinate2DMake(37.317207, -113.022537);
    [self.mapView addAnnotation:defaultPoint5];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[[LocationController sharedController]manager]startUpdatingLocation];
    
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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 600, 600);
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)mapLongPressed:(UILongPressGestureRecognizer *)sender {

    if(sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self.mapView];
        
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *newMapPoint = [[MKPointAnnotation alloc]init];
        newMapPoint.title = @"New Location";
        newMapPoint.coordinate = touchMapCoordinate;
        
        [self.mapView addAnnotation:newMapPoint];
        
    }

}

//MARK: LocationControllerDelegate
-(void)locationControllerUpdatedLocation:(CLLocation *)location{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0);
    [self.mapView setRegion:region];
    
}



//MARK: MKMapViewDelegate

//HOMEWORK: Write a function in this method that generates a random color for the head of the pin.

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
    annotationView.annotation = annotation;
    
    if(!annotationView){
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    }
    
    
    uint32_t randomIndex = arc4random_uniform(self.colorArray.count);
    
    
    self.colorArray = [[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor], [UIColor greenColor], [UIColor yellowColor], [UIColor whiteColor], [UIColor blackColor], [UIColor purpleColor], [UIColor brownColor], [UIColor cyanColor], [UIColor magentaColor], nil];
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    annotationView.pinTintColor = self.colorArray[randomIndex];
    
    UIButton *rightCalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    annotationView.rightCalloutAccessoryView = rightCalloutButton;
    
    return annotationView;
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString: @"DetailViewController"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            MKAnnotationView *annotationView = (MKAnnotationView *)sender;
            
            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            
            detailViewController.annotationTitle = annotationView.annotation.title;
            detailViewController.coordinate = annotationView.annotation.coordinate;
        }
    }
}



//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//
//       
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
