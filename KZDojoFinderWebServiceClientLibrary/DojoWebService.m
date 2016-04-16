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
+(NSArray<WSDojo*>*)dojosWithin:(CLLocationCoordinate2D)regionFrom to:(CLLocationCoordinate2D)regionTo error:(NSError* _Nullable *)error{
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
	
	NSMutableArray* dojos;
	NSURL *url = urlComponents.URL;
	NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:error];
	if (data) {
		NSError *parseError;
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
		if (!parseError) {
			NSString *status = [json objectForKey:@"status"];
			NSNumber *count = [json objectForKey:@"count"];
			if ([@"ok" isEqualToString:status]) {
				NSArray *responses = [json objectForKey:@"dojos"];
				dojos = [[NSMutableArray alloc] init];
				for (NSDictionary* obj in responses) {
					[dojos addObject:[DojoWebServiceUtilites makeDojoFromResponse:obj]];
				}
			} else {
				// Alert caller?
				NSString *errorString = [json objectForKey:@"error"];
				NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorString};
				NSLog(@"Return with error of %@", errorString);
				*error = [NSError errorWithDomain:DojoWebServiceErrorDomain code:DojoWebServiceWebServerError userInfo:userInfo];
			}
		} else {
			NSLog(@"Parser Error %@", [parseError localizedDescription]);
			NSLog(@"        with %@", [parseError userInfo]);
			*error = parseError;
		}
	}
	
	return dojos;
}

+(NSURLQueryItem*)makeQueryItemForKey:(NSString*)key andValue:(NSString*)value {
	return [[NSURLQueryItem alloc] initWithName:key value:value];
}
	 
+(NSString*)doubleToString:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}
@end
