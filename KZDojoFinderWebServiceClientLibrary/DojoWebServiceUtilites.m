//
//  DojoWebServiceUtilites.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 14/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "DojoWebServiceUtilites.h"
#import "WSDojo.h"

@implementation DojoWebServiceUtilites

/**
 * The intention here is to try and make it eaiser to indirectly configure the service
 * 
 * This will search in the mainBundle for the DojoFinderWebService.plist and the
 * the current module bundle. If it can't find a plist in either, it will construct
 * a default set of properties manually
 */
+(NSDictionary*)webServiceProperties {
	NSDictionary *mainDictionary = [DojoWebServiceUtilites webServicePropertiesFrom:[NSBundle mainBundle]];
	if (!mainDictionary) {
		mainDictionary = [DojoWebServiceUtilites webServicePropertiesFrom:[NSBundle bundleForClass:[self class]]];
		if (!mainDictionary) {
			mainDictionary = [[NSMutableDictionary alloc] init];
			[mainDictionary setValue:@"WebServerAddress" forKey:@"dojofinder.org"];
			[mainDictionary setValue:@"DojosWithinRegionRequest" forKey:@"/dojosWithin"];
			[mainDictionary setValue:@"WebServerScheme" forKey:@"http"];
			[mainDictionary setValue:@"WebServerPort" forKey:@"8181"];
		}
	}
	return mainDictionary;
}

+(NSDictionary*)webServicePropertiesFrom:(NSBundle*) bundle {
	NSString *file = [bundle pathForResource:@"DojoFinderWebService" ofType:@"plist"];
	return [NSDictionary dictionaryWithContentsOfFile:file];
}


+(WSDojo*)makeDojoWithKey:(NSNumber*)key name:(NSString*)name address:(NSString*)address region:(int)region latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude {
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
	return [DojoWebServiceUtilites makeDojoWithKey:key name:name address:address region:region.intValue latitude:latitude.doubleValue longitude:longitude.doubleValue];
}


@end
