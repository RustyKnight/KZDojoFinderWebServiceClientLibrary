//
//  WSRegionContact.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 19/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "WSRegionContact.h"
#import "RegionContactWebService.h"

@implementation WSRegionContact {
}

@synthesize key;
@synthesize name;
@synthesize phoneNumber;
@synthesize faceBook;
@synthesize email;
@synthesize region;

-(id)initWithKey:(NSInteger)aKey
						name:(NSString*)aName
		 phoneNumber:(NSString*)aPhoneNumber
					 email:(NSString*)aEmail
				facebook:(NSString*)aFacebook
					region:(int)aRegion {
	if (self = [super init]) {
		key = aKey;
		name = aName;
		phoneNumber = aPhoneNumber;
		email = aEmail;
		faceBook = aFacebook;
		region = aRegion;
	}
	return self;
}

-(NSString*)description {
	NSMutableString* value = [[NSMutableString alloc] init];
	[value appendFormat:@"key = %zd", self.key];
	[value appendFormat:@"; name = %@", self.name];
	[value appendFormat:@"; phoneNumber = %@", self.phoneNumber];
	[value appendFormat:@"; email = %@", self.email];
	[value appendFormat:@"; phoneNumber = %@", self.phoneNumber];
	[value appendFormat:@"; faceBook = %@", self.faceBook];
	[value appendFormat:@"; region = %d", self.region];
	
	return value;
}

-(void)photoWithConsumer:(id<ImageConsumer>)consumer {
	
}

//
//
//-(void)photo:(void (^)(UIImage*))callBack {
//	
//	NSError *error = nil;
//	[RegionContactWebService pictureForRegionContact:self error:&error];
//
////	PFFile *file = self.parseObject[@"photo"];
////	if (file != nil) {
////
////		if (backgroundQueue == nil) {
////
////			backgroundQueue = dispatch_queue_create("org.kaizen.dojoFinder.photo", NULL);
////
////		}
////
////		dispatch_async(backgroundQueue, ^(void) {
////
////			NSLog(@"Start loading photo");
////			NSData *data = [file getData];
////			UIImage *picture = [UIImage imageWithData:data];
////			NSLog(@"Completed loading photo");
////
////			dispatch_async(dispatch_get_main_queue(), ^{
////				callBack(picture);
////			});
////
////		});
////
////	} else {
////
////		callBack(nil);
////
////	}
//
//}

- (BOOL)isEqual:(id)other {
	if (other == self)
		return YES;
	if (!other || ![[other class] isEqual:[self class]])
		return NO;

	return [self isEqualToContact:other];
}

- (BOOL)isEqualToContact:(WSRegionContact *)contact {
	if (self == contact)
		return YES;
	if (contact == nil)
		return NO;
	if (self.key != contact.key)
		return NO;
	return YES;
}

- (NSUInteger)hash {
	return (NSUInteger) self.key;
}

@end
