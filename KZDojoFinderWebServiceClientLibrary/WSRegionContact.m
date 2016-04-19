//
//  WSRegionContact.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 19/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "WSRegionContact.h"

@implementation WSRegionContact {
	NSString *_name;
	NSString *_phoneNumber;
	NSString *_email;
	NSString *_faceBook;
	int _region;
}
//@property NSString *name;
//@property NSString *phoneNumber;
//@property NSString *email;
//@property NSString *faceBook;
//@property int region;
//
//-(void) photo:(void (^)(UIImage*))callBack;

-(id)initWithKey:(NSNumber*)key name:(NSString*)name phoneNumber:(NSString*)phoneNumber email:(NSString*)email facebook:(NSString*)facebook region:(int)region {
	if (self = [super init]) {
		_key = key;
		_name = name;
		_phoneNumber = phoneNumber;
		_email = email;
		_faceBook = facebook;
		_region = region;
	}
	return self;
}

-(NSString *)name {
	return _name;
}

-(NSString *)phoneNumber {
	return _phoneNumber;
}

-(NSString *)email {
	return _email;
}

-(NSString *)faceBook {
	return _faceBook;
}

-(int)region {
	return _region;
}

-(NSString*)description {
	NSMutableString* value = [[NSMutableString alloc] init];
	[value appendFormat:@"key = %@", self.key];
	[value appendFormat:@"; name = %@", self.name];
	[value appendFormat:@"; phoneNumber = %@", self.phoneNumber];
	[value appendFormat:@"; email = %@", self.email];
	[value appendFormat:@"; phoneNumber = %@", self.phoneNumber];
	[value appendFormat:@"; faceBook = %@", self.faceBook];
	[value appendFormat:@"; region = %d", self.region];
	
	return value;
}


-(void)photo:(void (^)(UIImage*))callBack {

//	PFFile *file = self.parseObject[@"photo"];
//	if (file != nil) {
//
//		if (backgroundQueue == nil) {
//
//			backgroundQueue = dispatch_queue_create("org.kaizen.dojoFinder.photo", NULL);
//
//		}
//
//		dispatch_async(backgroundQueue, ^(void) {
//
//			NSLog(@"Start loading photo");
//			NSData *data = [file getData];
//			UIImage *picture = [UIImage imageWithData:data];
//			NSLog(@"Completed loading photo");
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

}


@end
