//
//  KZWSDojoFactory.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 13/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "DojoWebService.h"
#import "DojoFinderWebServiceUtilites.h"
#import "WebService.h"

@implementation DojoWebService
+(NSArray<WSDojo*>*)dojosWithin:(CLLocationCoordinate2D)regionFrom to:(CLLocationCoordinate2D)regionTo error:(NSError* _Nullable *)error{
	NSDictionary *mainDictionary = [DojoFinderWebServiceUtilites webServiceProperties];
	
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
//			NSNumber *count = [json objectForKey:@"count"];
			if ([@"ok" isEqualToString:status]) {
				NSArray *responses = [json objectForKey:@"dojos"];
				dojos = [[NSMutableArray alloc] init];
				for (NSDictionary* obj in responses) {
					[dojos addObject:[DojoFinderWebServiceUtilites makeDojoFromResponse:obj]];
				}
			} else {
				// Alert caller?
				NSString *errorString = [json objectForKey:@"error"];
				NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorString};
				NSLog(@"Return with error of %@", errorString);
				*error = [NSError errorWithDomain:DojoWebServiceErrorDomain code:DojoWebServiceError userInfo:userInfo];
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

//+(UIImage*)pictureForDojo:(WSDojo* _Nonnull)dojo withConsumer:(id<ImageConsumer> _Nonnull)consumer; {
//	return [DojoWebService pictureForDojoByKey:[dojo key] withConsumer:consumer];
//}
//
//+(UIImage*)pictureForDojoByKey:(NSNumber*  _Nonnull)dojoKey withConsumer:(id<ImageConsumer> _Nonnull)consumer; {
//	
//	NSString* cmdKey = @"PictureForDojo";
//	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
//	[parameters setObject:dojoKey forKey:@"dojo"];
//
//	__block UIImage* imagePicture = nil;
//	[DojoFinderWebServiceUtilites executeWebServiceForCommandKey:cmdKey
//																								withParameters:parameters
//																										withParser:^(NSDictionary* json) {
//																											
//																											NSNumber* count = json[@"count"];
//																											NSLog(@"Expcted %@ pictures", count);
//																											
//																											NSDictionary* properties = [json objectForKey:@"picture"];
//																											if (properties) {
//																												NSLog(@"Load encoded image data");
//																												NSString* data = [properties objectForKey:@"picture"];
//																												NSLog(@"Decode image data");
//																												NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:data options:0];
//																												NSLog(@"Make image");
//																												imagePicture = [[UIImage alloc] initWithData:decodedData];
//																											}
//																										}
//																									errorFactory:^NSError *(NSDictionary *userInfo) {
//																										return [NSError errorWithDomain:DojoServiceErrorDomain code:DojoWebServiceError userInfo:userInfo];
//																									}
//																												 error:error];
//	
//	return imagePicture;
//}

+(void)pictureForDojoByKey:(NSNumber*  _Nonnull)dojoKey withConsumer:(id<WebServiceConsumer> _Nonnull)consumer {
	
	NSString* cmdKey = @"PictureForDojo";
	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
	[parameters setObject:dojoKey forKey:@"dojo"];
	
	WebService* webService = [WebService serviceWithDelegate: delegate andConsumer:consumer];
	
	//	__block UIImage* imagePicture = nil;
	//	[DojoFinderWebServiceUtilites executeWebServiceForCommandKey:cmdKey
	//																								withParameters:parameters
	//																										withParser:^(NSDictionary* json) {
	//
	//																											NSNumber* count = json[@"count"];
	//																											NSLog(@"Expcted %@ pictures", count);
	//
	//																											NSDictionary* properties = [json objectForKey:@"picture"];
	//																											if (properties) {
	//																												NSLog(@"Load encoded image data");
	//																												NSString* data = [properties objectForKey:@"picture"];
	//																												NSLog(@"Decode image data");
	//																												NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:data options:0];
	//																												NSLog(@"Make image");
	//																												imagePicture = [[UIImage alloc] initWithData:decodedData];
	//																											}
	//																										}
	//																									errorFactory:^NSError *(NSDictionary *userInfo) {
	//																										return [NSError errorWithDomain:DojoServiceErrorDomain code:DojoWebServiceError userInfo:userInfo];
	//																									}
	//																												 error:error];
	//
	//	return imagePicture;
}

@end
