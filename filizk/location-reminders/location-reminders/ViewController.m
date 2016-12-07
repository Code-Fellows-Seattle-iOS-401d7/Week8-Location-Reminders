//
//  ViewController.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/5/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "ViewController.h"
#import "LocationController.h"
#import "DetailViewController.h"

@import MapKit;
@import Parse;

#import "MyQueue.h"
#import "MyStack.h"

@interface ViewController () <MKMapViewDelegate, LocationControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSMutableArray *locations;
//@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // Creating a test object.
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//
//    testObject[@"foo"] = @"bar";
//
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *_Nullable error) {
//        if (error) {
//            NSLog(@"%@", error.localizedDescription);
//            return;
//        }
//
//        if (succeeded) {
//            NSLog(@"Successfully saved testObject");
//        }
//    }];

    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSLog(@"%@", objects);
            }];
        }
    }];

    //[self requestPermissions];
    //[self.mapView setShowsUserLocation:YES];


    self.mapView.delegate = self;
    LocationController.sharedController.delegate = self;


    self.locations = [[NSMutableArray alloc]init];

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6580, -122.351096);
    MKPointAnnotation *newMapPoint = [[MKPointAnnotation alloc]init];
    newMapPoint.coordinate = coordinate;
    newMapPoint.title = @"Barber Top24";
    [self.locations addObject:newMapPoint];
    

    coordinate = CLLocationCoordinate2DMake(47.6570, -122.35109);
    newMapPoint = [[MKPointAnnotation alloc]init];
    newMapPoint.coordinate = coordinate;
    newMapPoint.title = @"Pizza Heaven";
    [self.locations addObject:newMapPoint];

    coordinate = CLLocationCoordinate2DMake(47.6550, -122.3530);
    newMapPoint = [[MKPointAnnotation alloc]init];
    newMapPoint.coordinate = coordinate;
    newMapPoint.title = @"Candy Shop";
    [self.locations addObject:newMapPoint];

    coordinate = CLLocationCoordinate2DMake(47.6575, -122.3512);
    newMapPoint = [[MKPointAnnotation alloc]init];
    newMapPoint.coordinate = coordinate;
    newMapPoint.title = @"Target";
    [self.locations addObject:newMapPoint];

    coordinate = CLLocationCoordinate2DMake(47.6567, -122.35109);
    newMapPoint = [[MKPointAnnotation alloc]init];
    newMapPoint.coordinate = coordinate;
    newMapPoint.title = @"Houzz";
    [self.locations addObject:newMapPoint];


    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [self.mapView setRegion:region animated:YES];

   // [self testQueue];
   // [self testStack];

}
- (IBAction)mapLongPressed:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self.mapView];

        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];

        MKPointAnnotation *newMapPoint = [[MKPointAnnotation alloc]init];
        newMapPoint.coordinate = touchMapCoordinate;
        newMapPoint.title = @"New Location";

       // [self.mapView addAnnotation:newMapPoint];

    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [[[LocationController sharedController] manager] startUpdatingLocation];

    for (MKPointAnnotation *annotation in self.locations) {
        [self.mapView addAnnotation:annotation];
    }

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6566, -122.351096);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);
    [self.mapView setRegion:region animated:YES];

}

//MARK: LocationContollerDelegate

-(void)locationControllerUpdatedLocation:(CLLocation *)location{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500);
//    [self.mapView setRegion:region];
}

//MARK: MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
    annotationView.annotation = annotation;

    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
    }

    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    annotationView.pinTintColor = [self generateRandomColor];

    UIButton *rightCalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    annotationView.rightCalloutAccessoryView = rightCalloutButton;

    return annotationView;

}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"DetailViewController"]) {
         if ([sender isKindOfClass:[MKAnnotationView class]]) {
             MKAnnotationView *annotationView = (MKAnnotationView *)sender;

             DetailViewController *detailViewController = segue.destinationViewController;

             detailViewController.annotationTitle = annotationView.annotation.title;
             detailViewController.coordinate = annotationView.annotation.coordinate;
         }
    }
}

-(UIColor *)generateRandomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

-(void)testQueue {
    MyQueue *myQ = [[MyQueue alloc]init];
    [myQ enqueue:@"1"];
    [myQ enqueue:@"2"];
    [myQ enqueue:@"3"];

    NSLog(@"**Last item before dequeue = %@", myQ.peek);
    NSString *dequedNum = [myQ dequeue];
    NSLog(@"**Dequed Number=  %@",dequedNum);
    NSLog(@"**Last number after dequeue = %@",myQ.peek);
    [myQ enqueue:@"4"];
    NSLog(@"**Last number after dequeue = %@",myQ.peek); 

    //See location_remindersTests for more tests
}

-(void)testStack {
    MyStack *myS = [[MyStack alloc]init];
    [myS push:@"1"];
    [myS push:@"2"];
    [myS push:@"3"];

    NSLog(@"**Last item before popping = %@", myS.peek);
    NSString *poppedNum = [myS pop];
    NSLog(@"**Popped Number=  %@",poppedNum);
    NSLog(@"**Last number after pop = %@",myS.peek);
    [myS push:@"4"];
    NSLog(@"**Last number after pop = %@",myS.peek); //

    //See location_remindersTests for more tests

}

//Only needed when local LocationManager was being used.
//-(void)requestPermissions {
//    [self setLocationManager:[[CLLocationManager alloc]init]];
//
//    [self.locationManager requestWhenInUseAuthorization];
//
//}
//Coordinates for Denmark: 55.676098, 12.568337
- (IBAction)setLocationToDenmark:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(55.676098, 12.568337);

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);

    [self.mapView setRegion:region animated:YES];

}

- (IBAction)setLocationToAfrica:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(0, 0);

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 2000000, 2000000);

    [self.mapView setRegion:region animated:YES];
}

//41.015137	28.979530
- (IBAction)setLocationToTurkey:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(41.015137, 28.979530);

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);

    [self.mapView setRegion:region animated:YES];

}

- (IBAction)setLocationPressed:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6566, -122.351096);

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500);

    [self.mapView setRegion:region animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
