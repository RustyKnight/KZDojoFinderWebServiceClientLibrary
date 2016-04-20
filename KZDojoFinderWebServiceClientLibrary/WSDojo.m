//
//  WSDojo.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

@import MapKit;
#import "WSDojo.h"

@implementation WSDojo {
//	NSString *_name;
//	NSString *_address;
////	int _region;
//	CLLocation* _location;
}

@synthesize region;
@synthesize name;
@synthesize address;
@synthesize location;

-(id)initWithKey:(NSNumber*)key name:(NSString*)aName address:(NSString*)aAddress region:(int)aRegion latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
	if (self = [super init]) {
		_key = key;
		name = aName;
		address = aAddress;
		region = aRegion;
		location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
	}
	return self;
}

-(NSString*)description {
	NSMutableString* value = [[NSMutableString alloc] init];
	[value appendFormat:@"Dojo: "];
	[value appendFormat:@"key = %@", self.key];
	[value appendFormat:@"; name = %@", self.name];
	[value appendFormat:@"; address = %@", self.address];
	[value appendFormat:@"; region = %d", self.region];
	[value appendFormat:@"; location = %@", self.location];
	
	return value;
}

//-(NSString*)name {
//	return _name;
//}
//
//-(NSString *)address {
//	return _address;
//}
//
//-(CLLocation *)location {
//	return _location;
//}
//
//-(int)region {
//	return _region;
//}

-(void)picture:(void (^)(UIImage *))callBack {
}

//-(void)picture:(void (^)(UIImage *))callBack {
//
//	PFFile *file = _pfObject[@"picture"];
//	if (file != nil) {
//
//		if (backgroundQueue == nil) {
//
//			backgroundQueue = dispatch_queue_create("org.kaizen.dojoFinder.picture", NULL);
//
//		}
//
//		dispatch_async(backgroundQueue, ^(void) {
//
//			NSLog(@"Start loading dojo picture");
//			NSData *data = [file getData];
//			UIImage *picture = [UIImage imageWithData:data];
//			NSLog(@"Completed loading picture");
//
//			dispatch_async(dispatch_get_main_queue(), ^{
//				callBack(picture);
//			});
//
//		});
//
//	} else {
//
//		callBack(nil);
//
//	}

@end
