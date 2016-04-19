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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	NSError* error;
	// Do any additional setup after loading the view, typically from a nib.
//	CLLocationCoordinate2D from = CLLocationCoordinate2DMake(-38.099965, 145.071030);
//	CLLocationCoordinate2D to = CLLocationCoordinate2DMake(-38.186699, 145.180854);
//	NSArray<WSDojo*>* dojos = [DojoWebService dojosWithin:from to:to error:&error];
//	NSLog(@"Got %d dojos", dojos.count);
//	if (!error) {
//		for (WSDojo* dojo in dojos) {
//			NSArray<WSSession*>* sessions = [SessionWebService sessionsForDojo:dojo error:&error];
//			NSLog(@"Got %d sessions", sessions.count);
//			if (error) {
//				NSLog(@" error => %@ ", [error localizedDescription] );
//				break;
//			}
//		}
//	} else {
//		NSLog(@" error => %@ ", [error localizedDescription] );
//	}
	
	UIImage* image = [DojoWebService pictureForDojoByKey:[NSNumber numberWithInt:383] error:&error];
	if (!error) {
		if (image) {
			NSLog(@"Image was loaded");
			self.imageView.image = image;
		} else {
			NSLog(@"Image was not loaded");
		}
	} else {
		NSLog(@" error => %@ ", [error localizedDescription] );
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
