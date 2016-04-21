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
#import "WebServiceDelegate.h"
#import "WebServiceConsumer.h"
#import "DefaultWebServiceDelegate.h"

static WebServiceErrorFactory dojoWebServiceErrorFactory = ^NSError * _Nonnull (NSDictionary * _Nonnull userInfo) {
	return [NSError errorWithDomain:DojoServiceErrorDomain
														 code:DojoWebServiceError
												 userInfo:userInfo];
};

@implementation DojoWebService

//+(NSArray<WSDojo*>*)dojosWithin:(CLLocationCoordinate2D)regionFrom to:(CLLocationCoordinate2D)regionTo error:(NSError* _Nullable *)error{
//	NSDictionary *mainDictionary = [DojoFinderWebServiceUtilites webServiceProperties];
//	
//	NSString* serverAddress = [mainDictionary valueForKey:@"WebServerAddress"];
//	NSString* request = [mainDictionary valueForKey:@"DojosWithinRegionRequest"];
//	NSString* serverScheme = [mainDictionary valueForKey:@"WebServerScheme"];
//	NSNumber* serverPort = [mainDictionary valueForKey:@"WebServerPort"];
//	
//	NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
//	urlComponents.scheme = serverScheme;
//	urlComponents.host = serverAddress;
//	urlComponents.path = request;
//	urlComponents.port = serverPort;
//	
//	NSMutableArray<NSURLQueryItem*> *queryItems = [[NSMutableArray alloc] init];
//	[queryItems addObject:
//	 [DojoWebService makeQueryItemForKey:@"startLat"
//															 andValue:[DojoWebService doubleToString:regionFrom.latitude]]];
//	[queryItems addObject:
//	 [DojoWebService makeQueryItemForKey:@"startLon"
//															 andValue:[DojoWebService doubleToString:regionFrom.longitude]]];
//	[queryItems addObject:
//	 [DojoWebService makeQueryItemForKey:@"endLat"
//															 andValue:[DojoWebService doubleToString:regionTo.latitude]]];
//	[queryItems addObject:
//	 [DojoWebService makeQueryItemForKey:@"endLon"
//															 andValue:[DojoWebService doubleToString:regionTo.longitude]]];
//	urlComponents.queryItems = queryItems;
//	
//	NSMutableArray* dojos;
//	NSURL *url = urlComponents.URL;
//	NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:error];
//	if (data) {
//		NSError *parseError;
//		NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
//		if (!parseError) {
//			NSString *status = [json objectForKey:@"status"];
////			NSNumber *count = [json objectForKey:@"count"];
//			if ([@"ok" isEqualToString:status]) {
//				NSArray *responses = [json objectForKey:@"dojos"];
//				dojos = [[NSMutableArray alloc] init];
//				for (NSDictionary* obj in responses) {
//					[dojos addObject:[DojoFinderWebServiceUtilites makeDojoFromResponse:obj]];
//				}
//			} else {
//				// Alert caller?
//				NSString *errorString = [json objectForKey:@"error"];
//				NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorString};
//				NSLog(@"Return with error of %@", errorString);
//				*error = [NSError errorWithDomain:DojoWebServiceErrorDomain code:DojoWebServiceError userInfo:userInfo];
//			}
//		} else {
//			NSLog(@"Parser Error %@", [parseError localizedDescription]);
//			NSLog(@"        with %@", [parseError userInfo]);
//			*error = parseError;
//		}
//	}
//	
//	return dojos;
//}

//+(NSURLQueryItem*)makeQueryItemForKey:(NSString*)key andValue:(NSString*)value {
//	return [[NSURLQueryItem alloc] initWithName:key value:value];
//}

+(NSString*)doubleToString:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}

+(void)pictureForDojo:(WSDojo* _Nonnull)dojo withConsumer:(id<WebServiceConsumer> _Nonnull)consumer {
	[DojoWebService pictureForDojoByKey:[dojo key] withConsumer:consumer];
}

+(void)pictureForDojoByKey:(NSNumber*  _Nonnull)dojoKey withConsumer:(id<WebServiceConsumer> _Nonnull)consumer {
	
	NSString* cmdKey = @"PictureForDojo";
	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
	[parameters setObject:dojoKey forKey:@"dojo"];
	
	DefaultWebServiceDelegate* delegate =
	[DefaultWebServiceDelegate
	 serviceWithCommandKey:cmdKey
	 andParameters:parameters
	 andComplitationHandler:^NSObject * _Nullable (NSDictionary * _Nonnull json) {
		 NSNumber* count = json[@"count"];
		 NSLog(@"Expcted %@ pictures", count);
		 
		 return [DojoFinderWebServiceUtilites decodeImageFromJsonResponse:json withKey:@"picture"];
	 }
	 andErrorHandler:dojoWebServiceErrorFactory];
	
	[DojoFinderWebServiceUtilites executeWebServiceWithDelegate:delegate andConsumer:consumer];
	
}

+(void)dojosWithin:(CLLocationCoordinate2D)regionFrom
								to:(CLLocationCoordinate2D)regionTo
			 withConsume:(id<WebServiceConsumer> _Nonnull)consumer {

	NSString* cmdKey = @"DojosWithinRegionRequest";
	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
	
	[parameters setObject:[DojoWebService doubleToString:regionFrom.latitude] forKey:@"startLat"];
	[parameters setObject:[DojoWebService doubleToString:regionFrom.longitude] forKey:@"startLon"];
	[parameters setObject:[DojoWebService doubleToString:regionTo.latitude] forKey:@"endLat"];
	[parameters setObject:[DojoWebService doubleToString:regionTo.longitude] forKey:@"endLon"];
	
	DefaultWebServiceDelegate* delegate =
	[DefaultWebServiceDelegate
	 serviceWithCommandKey:cmdKey
	 andParameters:parameters
	 andComplitationHandler:^NSObject * _Nullable(NSDictionary * _Nonnull json) {
		 NSArray *responses = [json objectForKey:@"dojos"];
		 NSMutableArray* dojos = [[NSMutableArray alloc] init];
		 for (NSDictionary* obj in responses) {
			 [dojos addObject:[DojoFinderWebServiceUtilites makeDojoFromResponse:obj]];
		 }
		 return dojos;
	 } andErrorHandler:dojoWebServiceErrorFactory];
	
	[DojoFinderWebServiceUtilites executeWebServiceWithDelegate:delegate andConsumer:consumer];
}

@end
