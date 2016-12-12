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
#import "Reminder.h"


#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>



@import MapKit;

@interface ViewController ()<MKMapViewDelegate, LocationControllerDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(strong, nonatomic) CLLocationManager *locationManager;

@property(strong, nonatomic) UIColor *pinTintColor;

@property(strong, nonatomic) NSArray *colorArray;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Reminder *testReminder = [Reminder object];
    testReminder.title = @"New Reminder";
    [testReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        if (succeeded) {
            NSLog(@"Check your dashboard for saved reminder.");
        }
    }];
    
        PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    
    
    
        testObject[@"foo"] = @"bar";
    
        [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error){
    
            if(error) {
                NSLog(@"%@", error.localizedDescription);
                return;
            }
    
            if(succeeded) {
                NSLog(@"Successfully saved testObject");
            }
            
        }];

    
    [self requestPermissions];
    
    self.mapView.delegate = self;
    [LocationController sharedController].delegate = self;

    [self.mapView setShowsUserLocation:YES];
    [self login];

    
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reminderCreatedNotificationFired) name:@"ReminderCreated" object:nil];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ReminderCreated" object:nil];
}

-(void)reminderCreatedNotificationFired{
    
    NSLog(@"Reminder was created. NSLog fired from %@", self);
    
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
    
    
//    int randomIndex = arc4random_uniform(self.colorArray.count);
    NSNumber *randomIndex = [NSNumber numberWithUnsignedInt:arc4random_uniform(self.colorArray.count)];
    
    self.colorArray = [[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor], [UIColor greenColor], [UIColor yellowColor], [UIColor whiteColor], [UIColor blackColor], [UIColor purpleColor], [UIColor brownColor], [UIColor cyanColor], [UIColor magentaColor], nil];
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    annotationView.pinTintColor = self.colorArray[randomIndex.intValue];
    
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
            
            __weak typeof(self) bruce = self;
            
            detailViewController.completion = ^(MKCircle *circle){
                
                __strong typeof(bruce) hulk = bruce;
                
                [hulk.mapView removeAnnotation:annotationView.annotation];
                [hulk.mapView addOverlay:circle]; //this line triggers MKOverlayRenderer method below
                
                
            };
            
        }
    }
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    MKCircleRenderer *renderer = [[MKCircleRenderer alloc]initWithOverlay:overlay];
    renderer.fillColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.25];
    renderer.alpha = 0.5;
    
    return renderer;
    
}



//MARK: ParseUI Stuff
-(void)login{
    
    if (![PFUser currentUser]) {
        
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc]init];
        loginViewController.delegate = self;
        loginViewController.signUpController.delegate = self;
        
        [self presentViewController:loginViewController animated:YES completion:nil];
        
    } else {
        [self setupAdditionalUI];
    }
    
}

-(void)setupAdditionalUI{
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOutPressed)];
    
    self.navigationItem.leftBarButtonItem = signOutButton;
}


-(void)signOutPressed{
    [PFUser logOut];
    [self login];
}


//MARK: Parse Delegate Methods

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI];
}

-(void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController{
    [self login];
}

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI];
}







@end
