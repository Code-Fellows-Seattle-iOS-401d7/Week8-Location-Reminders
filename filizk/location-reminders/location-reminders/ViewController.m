//
//  ViewController.m
//  location-reminders
//
//  Created by Filiz Kurban on 12/5/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

#import "ViewController.h"

@import MapKit;
@import Parse;

#import "MyQueue.h"
#import "MyStack.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

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

    [self requestPermissions];
    [self.mapView setShowsUserLocation:YES];

    [self testStack];

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
    NSLog(@"**Last number after dequeue = %@",myQ.peek); //Should be 4

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
    NSLog(@"**Last number after pop = %@",myS.peek); //Should be 4
    
}

-(void)requestPermissions {
    [self setLocationManager:[[CLLocationManager alloc]init]];

    [self.locationManager requestWhenInUseAuthorization];

}
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
