//
//  SessionWebService.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "SessionWebService.h"
#import "DojoWebServiceUtilites.h"

typedef void (^WebServiceParser)(NSDictionary*);
typedef NSError* (^WebServiceErrorFactory)(NSDictionary*);

@implementation SessionWebService
+(NSArray<WSSession*>*)sessionsForDojo:(WSDojo *)dojo error:(NSError* _Nullable *)error {
	return [SessionWebService sessionsForDojoKey:dojo.key error:error];
}

+(NSArray<WSSession*>*)sessionsForDojoKey:(NSNumber*)dojoKey error:(NSError* _Nullable *)error {
	
	NSString* cmdKey = @"SessionsForDojo";
	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
	[parameters setObject:dojoKey forKey:@"dojo"];

	NSMutableArray<WSSession*>* sessions = [[NSMutableArray alloc] init];
	[SessionWebService executeWebServiceForCommandKey:cmdKey
																		 withParameters:parameters
																			withParser:^(NSDictionary* json) {
																				
																				NSNumber* count = json[@"count"];
																				NSLog(@"Expcted %@ sessions", count);
																				WSDojo* dojo = [DojoWebServiceUtilites makeDojoFromResponse:[json objectForKey:@"dojo"]];
																				NSArray* sessionResponses = json[@"sessions"];
																				for (NSDictionary* response in sessionResponses) {
																					NSNumber* key = response[@"key"];
																					NSNumber* dojokey = response[@"dojokey"];
																					NSNumber* dayofweek = response[@"dayofweek"];
																					NSString* details = response[@"details"];
																					NSNumber* endtime = response[@"endtime"];
																					NSNumber* starttime = response[@"starttime"];
																					NSNumber* type = response[@"type"];
																					
																					WSSession* session = [[WSSession alloc] initWithKey:key dojo:dojo dayOfWeek:dayofweek details:details startTime:starttime endTime:endtime type:type];
																					[sessions addObject:session];
																				}
																			}
																			 errorFactory:^NSError *(NSDictionary *userInfo) {
																				return [NSError errorWithDomain:SessionServiceErrorDomain code:DojoSessionWebServiceWebServerError userInfo:userInfo];
																			}
																							error:error];
	
	return sessions;
}

+(NSURLQueryItem*)makeQueryItemForKey:(NSString*)key andValue:(NSString*)value {
	return [[NSURLQueryItem alloc] initWithName:key value:value];
}

+(NSString*)doubleToString:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}

+(void)executeWebServiceForCommandKey:(NSString *)cmdKey
											 withParameters:(NSDictionary<NSString*, NSObject*>*)parameters
												withParser:(WebServiceParser)parser
												 errorFactory:(WebServiceErrorFactory)errorFactory
																error:(NSError* _Nullable*)error {
	
	NSDictionary *mainDictionary = [DojoWebServiceUtilites webServiceProperties];
	
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
		 [SessionWebService makeQueryItemForKey:key
																andValue:[NSString stringWithFormat:@"%@", value]]];
	}
	urlComponents.queryItems = queryItems;
	
	NSMutableArray* results;
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

@end
