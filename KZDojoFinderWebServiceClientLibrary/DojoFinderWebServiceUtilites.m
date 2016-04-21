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
 * This will search in the mainBundle for the DojoFinderWebService.plist and the
 * the current module bundle. If it can't find a plist in either, it will construct
 * a default set of properties manually
 */
+(NSDictionary*)webServiceProperties {
	NSDictionary *mainDictionary = [DojoFinderWebServiceUtilites webServicePropertiesFrom:[NSBundle mainBundle]];
	if (!mainDictionary) {
		mainDictionary = [DojoFinderWebServiceUtilites webServicePropertiesFrom:[NSBundle bundleForClass:[self class]]];
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
	return [DojoFinderWebServiceUtilites makeDojoWithKey:key name:name address:address region:region.intValue latitude:latitude.doubleValue longitude:longitude.doubleValue];
}

+(void)executeWebServiceForCommandKey:(NSString *)cmdKey
											 withParameters:(NSDictionary<NSString*, NSObject*>*)parameters
													 withParser:(WebServiceParser)parser
												 errorFactory:(WebServiceErrorFactory)errorFactory
																error:(NSError* _Nullable*)error {
	
	NSDictionary *mainDictionary = [DojoFinderWebServiceUtilites webServiceProperties];
	
	NSString* serverAddress = [mainDictionary valueForKey:@"WebServerAddress"];
	NSString* request = [mainDictionary valueForKey:cmdKey];
	NSString* serverScheme = [mainDictionary valueForKey:@"WebServerScheme"];
	NSNumber* serverPort = [mainDictionary valueForKey:@"WebServerPort"];
	
	NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
	urlComponents.scheme = serverScheme;
	urlComponents.host = serverAddress;
	urlComponents.path = request;
	urlComponents.port = serverPort;
	
	NSMutableArray<NSURLQueryItem*> *queryItems = [[NSMutableArray alloc] init];
	for (NSString *key in parameters) {
		NSObject* value = [parameters objectForKey:key];
		[queryItems addObject:
		 [DojoFinderWebServiceUtilites makeQueryItemForKey:key
																	 andValue:[NSString stringWithFormat:@"%@", value]]];
	}
	urlComponents.queryItems = queryItems;
	
//	NSMutableArray* results;
	NSURL *url = urlComponents.URL;
	NSLog(@"%@", url);
	
	NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:error];
	if (data) {
		NSError *parseError;
		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
		if (!parseError) {
			NSString *status = [json objectForKey:@"status"];
			if ([@"ok" isEqualToString:status]) {
				parser(json);
			} else {
				NSString *errorString = [json objectForKey:@"error"];
				NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorString};
				NSLog(@"Return with error of %@", errorString);
				*error = errorFactory(userInfo);
			}
		} else {
			NSLog(@"Parser Error %@", [parseError localizedDescription]);
			NSLog(@"        with %@", [parseError userInfo]);
			*error = parseError;
		}
	}
	
}

+(NSURLQueryItem*)makeQueryItemForKey:(NSString*)key andValue:(NSString*)value {
	return [[NSURLQueryItem alloc] initWithName:key value:value];
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
