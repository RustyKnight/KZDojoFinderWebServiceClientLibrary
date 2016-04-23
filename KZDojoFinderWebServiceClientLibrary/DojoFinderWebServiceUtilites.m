//
//  DojoWebServiceUtilites.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 14/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "DojoFinderWebServiceUtilites.h"
#import "WSDojo.h"

@implementation DojoFinderWebServiceUtilites

/**
 * The intention here is to try and make it eaiser to indirectly configure the service
 *
 * This will merage the DojoFinderWebService.plist files from the class bundle and then
 * the main bundle, allowing keys to be overridden
 *
 * If "core" keys are missing, then defaults will be supplied, but this does not
 * gurentee that some keys could result in nil values, it's up to the library
 * implementation to ensure that the keys are filled out and are correct
 */
+(NSDictionary*)webServiceProperties {
	NSMutableDictionary *mergedDictionary = [[NSMutableDictionary alloc] init];
	NSDictionary* mainDictionary = [DojoFinderWebServiceUtilites webServicePropertiesFrom:[NSBundle bundleForClass:[self class]]];
	if (mainDictionary) {
		[mergedDictionary addEntriesFromDictionary:mainDictionary];
	}
	mainDictionary = [DojoFinderWebServiceUtilites webServicePropertiesFrom:[NSBundle mainBundle]];
	if (mainDictionary) {
		[mergedDictionary addEntriesFromDictionary:mainDictionary];
	}
	
	[DojoFinderWebServiceUtilites ensureValue:@"dojofinder.org" forKey:@"WebServerAddress" isAvailableIn:mergedDictionary];
	[DojoFinderWebServiceUtilites ensureValue:@"/dojosWithin" forKey:@"DojosWithinRegionRequest" isAvailableIn:mergedDictionary];
	[DojoFinderWebServiceUtilites ensureValue:@"/contactForRegion" forKey:@"ContactForRegionRequest" isAvailableIn:mergedDictionary];
	[DojoFinderWebServiceUtilites ensureValue:@"/regionContactPicture" forKey:@"PictureForRegionContactRequest" isAvailableIn:mergedDictionary];
	[DojoFinderWebServiceUtilites ensureValue:@"/dojoPicture" forKey:@"PictureForDojoRequest" isAvailableIn:mergedDictionary];
	[DojoFinderWebServiceUtilites ensureValue:@"/sessionsForDojo" forKey:@"SessionsForDojoRequest" isAvailableIn:mergedDictionary];
	[DojoFinderWebServiceUtilites ensureValue:@"http" forKey:@"WebServerScheme" isAvailableIn:mergedDictionary];
	[DojoFinderWebServiceUtilites ensureValue:@"8181" forKey:@"WebServerPort" isAvailableIn:mergedDictionary];
	
	return mainDictionary;
}

+(void)ensureValue:(NSString*)value forKey:(NSString*) key isAvailableIn:(NSMutableDictionary*)dictionary {
	if (![dictionary valueForKey:key]) {
		[dictionary setValue:value forKey:key];
	}
}

+(NSDictionary*)webServicePropertiesFrom:(NSBundle*) bundle {
	NSString *file = [bundle pathForResource:@"DojoFinderWebService" ofType:@"plist"];
	return [NSDictionary dictionaryWithContentsOfFile:file];
}


+(WSDojo*)makeDojoWithKey:(NSInteger)key name:(NSString*)name address:(NSString*)address region:(int)region latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
	WSDojo* dojo = [[WSDojo alloc] initWithKey:key name:name address:address region:region latitude:latitude longitude:longitude];
	return dojo;
}

+(WSDojo*)makeDojoFromResponse:(NSDictionary*)response {
	NSNumber* key = response[@"key"];
	NSString* name = response[@"name"];
	NSString* address = response[@"address"];
	NSNumber* region = response[@"region"];
	NSNumber* latitude = response[@"latitude"];
	NSNumber* longitude = response[@"longitude"];
	return [DojoFinderWebServiceUtilites makeDojoWithKey:[key integerValue] name:name address:address region:region.intValue latitude:latitude.doubleValue longitude:longitude.doubleValue];
}

+(void)executeWebServiceWithDelegate:(id<WebServiceDelegate> _Nonnull)delegate andConsumer:(id<WebServiceConsumer> _Nonnull) consumer {
	WebService* service = [WebService serviceWithDelegate:delegate andConsumer:consumer];
	[service execute];
}

+(UIImage* _Nullable)decodeImageFromJsonResponse:(NSDictionary* _Nonnull)json withKey:(NSString* _Nonnull)key {
	
	NSDictionary* properties = [json objectForKey:@"picture"];
	UIImage* imagePicture = nil;
	if (properties) {
		NSLog(@"Load encoded image data");
		NSString* data = [properties objectForKey:@"picture"];
		NSLog(@"Decode image data");
		NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:data options:0];
		NSLog(@"Make image");
		imagePicture = [[UIImage alloc] initWithData:decodedData];
	}
	
	return imagePicture;

}

@end
