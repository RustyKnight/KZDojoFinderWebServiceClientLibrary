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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	NSError* error;
	// Do any additional setup after loading the view, typically from a nib.
	CLLocationCoordinate2D from = CLLocationCoordinate2DMake(-38.099965, 145.071030);
	CLLocationCoordinate2D to = CLLocationCoordinate2DMake(-38.186699, 145.180854);
	[DojoWebService dojosWithin:from to:to error:&error];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
