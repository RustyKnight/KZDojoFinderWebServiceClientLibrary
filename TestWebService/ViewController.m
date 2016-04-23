//
//  ViewController.m
//  TestWebService
//
//  Created by Shane Whitehead on 14/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "ViewController.h"
//#import <KZDojoFinderWebServiceClientLibrary/KZDojoFinderWebServiceClientLibrary.h>
#import "DojoWebService.h"
#import "SessionWebService.h"
#import "RegionContactWebService.h"
#import <KZDojoFinderLibrary/KZDojoFinderLibrary.h>
#import "WebServiceImageConsumer.h"

@interface ViewController () <ImageConsumer, WebServiceConsumer>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
//	NSError* error;
	// Do any additional setup after loading the view, typically from a nib.
	CLLocationCoordinate2D from = CLLocationCoordinate2DMake(-38.099965, 145.071030);
	CLLocationCoordinate2D to = CLLocationCoordinate2DMake(-38.186699, 145.180854);
	[DojoWebService dojosWithin:from to:to withConsumer:self];
	[SessionWebService sessionsForDojoByKey:383 withConsumer:self];
//	NSArray<WSDojo*>* dojos = [DojoWebService dojosWithin:from to:to error:&error];
//	NSLog(@"Got %d dojos", dojos.count);
//	if (!error) {
//		for (WSDojo* dojo in dojos) {
//			NSLog(@"Got %@ sessions", dojo);
//			NSArray<WSSession*>* sessions = [SessionWebService sessionsForDojo:dojo error:&error];
//			NSLog(@"Got %d sessions", sessions.count);
//			if (error) {
//				NSLog(@" error => %@ ", [error localizedDescription] );
//				break;
//			} else {
//				for (WSSession* session in sessions) {
//					NSLog(@"%@", session);
//				}
//			}
//		}
//	} else {
//		NSLog(@" error => %@ ", [error localizedDescription] );
//	}
	
	
	
//	WebServiceImageConsumer* webServiceConsumer = [WebServiceImageConsumer withImageConsumer:self];
//	[DojoWebService pictureForDojoByKey:[NSNumber numberWithInt:383] withConsumer:webServiceConsumer];
	
//	WSRegionContact* contact = [RegionContactWebService regionContactForRegion:[NSNumber numberWithInt:7] error:&error];
//	if (!error) {
//		NSLog(@"%@", contact);
//	} else {
//		NSLog(@" error => %@ ", [error localizedDescription] );
//	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)imageDidLoad:(UIImage *)image {
	NSLog(@"imageWasLoaded");
	self.imageView.image = image;
}

-(void)imageDidFailWithError:(NSError *)error {
	NSLog(@"Image failed = %@", error.localizedDescription);
}

-(void)imageProgressDidChange:(NSNumber *)progress {
	NSLog(@"Image progress = %@", progress);
}

-(void)webService:(WebService *)webService didCompleteWith:(NSObject *)data {
	NSLog(@"WebService didCompleteWith = %@", data);
}

-(void)webService:(WebService *)webService didFailWithError:(NSError *)error {
	NSLog(@"WebService failed = %@", error.localizedDescription);
}

-(void)webService:(WebService *)webService progressDidChange:(NSNumber *)progress {
	NSLog(@"WebService progress = %@", progress);
}

@end
