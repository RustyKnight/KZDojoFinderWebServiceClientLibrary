//
//  WSDojo.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

@import MapKit;
#import "WSDojo.h"
#import "DojoWebService.h"
#import "WebServiceImageConsumer.h"

@implementation WSDojo {
}

static dispatch_queue_t backgroundQueue;

@synthesize region;
@synthesize name;
@synthesize address;
@synthesize location;

-(id)initWithKey:(NSInteger)key name:(NSString*)aName address:(NSString*)aAddress region:(int)aRegion latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
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
	[value appendFormat:@"key = %zd", self.key];
	[value appendFormat:@"; name = %@", self.name];
	[value appendFormat:@"; address = %@", self.address];
	[value appendFormat:@"; region = %d", self.region];
	[value appendFormat:@"; location = %@", self.location];
	
	return value;
}

-(void)photoWithConsumer:(id<ImageConsumer>)consumer {
	if (backgroundQueue == nil) {
		WebServiceImageConsumer* webServiceConsumer = [WebServiceImageConsumer withImageConsumer:consumer];
		[DojoWebService  pictureForDojoByKey:[self key] withConsumer:webServiceConsumer];
	}
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

- (BOOL)isEqual:(id)other {
	if (other == self)
		return YES;
	if (!other || ![[other class] isEqual:[self class]])
		return NO;

	return [self isEqualToDojo:other];
}

- (BOOL)isEqualToDojo:(WSDojo *)dojo {
	if (self == dojo)
		return YES;
	if (dojo == nil)
		return NO;
	if (self.key != dojo.key)
		return NO;
	return YES;
}

- (NSUInteger)hash {
	return (NSUInteger) self.key;
}

@end
