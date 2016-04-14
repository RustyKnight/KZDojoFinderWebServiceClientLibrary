//
//  KZWSDojoFactory.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 13/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "DojoWebService.h"
#import "DojoWebServiceUtilites.h"

@implementation DojoWebService
+(NSArray*)dojosWithin:(CLLocationCoordinate2D)regionFrom to:(CLLocationCoordinate2D)regionTo {
	NSDictionary *mainDictionary = [DojoWebServiceUtilites webServiceProperties];
	
	NSString* serverAddress = [mainDictionary valueForKey:@"WebServerAddress"];
	NSString* request = [mainDictionary valueForKey:@"DojosWithinRegionRequest"];
	NSString* serverScheme = [mainDictionary valueForKey:@"WebServerScheme"];
	NSNumber* serverPort = [mainDictionary valueForKey:@"WebServerPort"];
	
	NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
	urlComponents.scheme = serverScheme;
	urlComponents.host = serverAddress;
	urlComponents.path = request;
	urlComponents.port = serverPort;
	
	NSMutableArray<NSURLQueryItem*> *queryItems = [[NSMutableArray alloc] init];
	[queryItems addObject:
	 [DojoWebService makeQueryItemForKey:@"startLat"
															 andValue:[DojoWebService doubleToString:regionFrom.latitude]]];
	[queryItems addObject:
	 [DojoWebService makeQueryItemForKey:@"startLon"
															 andValue:[DojoWebService doubleToString:regionFrom.longitude]]];
	[queryItems addObject:
	 [DojoWebService makeQueryItemForKey:@"endLat"
															 andValue:[DojoWebService doubleToString:regionTo.latitude]]];
	[queryItems addObject:
	 [DojoWebService makeQueryItemForKey:@"endLon"
															 andValue:[DojoWebService doubleToString:regionTo.longitude]]];
	urlComponents.queryItems = queryItems;
	
	NSURL *url = urlComponents.URL;
	NSLog(@"Send request %@", url);
	NSData *data = [NSData dataWithContentsOfURL:url];
	if (data) {
		NSLog(@"Parse response");
		NSError *error;
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
		if (!error) {
			NSString *status = [json objectForKey:@"status"];
			NSNumber *count = [json objectForKey:@"count"];
			NSLog(@"Server responded with %@, expecting %@ dojos", status, count);
			if ([@"ok" isEqualToString:status]) {
				NSArray *responses = [json objectForKey:@"dojos"];
				NSLog(@"Returned with %lu dojos", (unsigned long)responses.count);
			} else {
				// Alert caller?
				NSString *error = [json objectForKey:@"error"];
				NSLog(@"Return with error of %@", error);
			}
		} else {
			NSLog(@"Parser Error %@", [error localizedDescription]);
			NSLog(@"        with %@", [error userInfo]);
		}
	} else {
		// Help!? What happend here?
	}
	
	return nil;
}

+(NSURLQueryItem*)makeQueryItemForKey:(NSString*)key andValue:(NSString*)value {
	return [[NSURLQueryItem alloc] initWithName:key value:value];
}
	 
+(NSString*)doubleToString:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}
@end
