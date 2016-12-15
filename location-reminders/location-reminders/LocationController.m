//
//  LocationController.m
//  location-reminders
//
//  Created by Corey Malek on 12/6/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

#import "LocationController.h"

@interface LocationController()<CLLocationManagerDelegate>

@end

@implementation LocationController

+(instancetype)sharedController{
    
    static LocationController *sharedController;
    
    //example of GCD
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[LocationController alloc]init];
        
    });
    
    return sharedController;
    
}

//5 custom errors

-(void)errorOne {
    NSString *domain = @"MyBad";
    NSInteger code  = 500;
    NSDictionary *userInfo = @{@"Description" : @"Server Error"};
    
    NSError *error = [NSError errorWithDomain:domain
                                        code:code
                                        userInfo:userInfo];
}

-(void)errorTwo {
    NSString *domain = @"YourBad";
    NSInteger code = 403;
    NSDictionary *userInfo = @{@"Description" : @"Can't Go There.."};
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:userInfo];
}



-(void)errorThree {
    NSString *domain = @"AllBad";
    NSInteger code = 400;
    NSDictionary *userInfo = @{@"Description" : @"Bad Request"};
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:userInfo];
}

-(void)errorFour {
    NSString *domain = @"PackedUp";
    NSInteger code = 301;
    NSDictionary *userInfo = @{@"Description" : @"Moved Permanently"};
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:userInfo];
}

-(void)errorFive {
    NSString *domain = @"NoSupport";
    NSInteger code = 415;
    NSDictionary *userInfo = @{@"Description" : @"Unsupported Media Type"};
    
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:userInfo];
}





-(instancetype)init{
    
    self = [super init];
    
    if(self){
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
        
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        _manager.distanceFilter = 100;
        
        [_manager requestAlwaysAuthorization];
        [_manager requestWhenInUseAuthorization];
        
        
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //come back to this
    [self.delegate locationControllerUpdatedLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
    
}


-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"Started Monitoring Region For: %@", region);
}




-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"User Did Enter Region. No bug. %@",region);
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{
    NSLog(@"Error");
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error");
}

-(void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error{
    NSLog(@"Error");
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"Left Region");
}

@end
