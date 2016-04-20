//
//  SessionWebService.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "SessionWebService.h"
#import "DojoFinderWebServiceUtilites.h"

@implementation SessionWebService
+(NSArray<WSSession*>*)sessionsForDojo:(WSDojo *)dojo error:(NSError* _Nullable *)error {
	return [SessionWebService sessionsForDojoKey:dojo.key error:error];
}

+(NSArray<WSSession*>*)sessionsForDojoKey:(NSNumber*)dojoKey error:(NSError* _Nullable *)error {
	
	NSString* cmdKey = @"SessionsForDojo";
	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
	[parameters setObject:dojoKey forKey:@"dojo"];

	NSMutableArray<WSSession*>* sessions = [[NSMutableArray alloc] init];
	[DojoFinderWebServiceUtilites executeWebServiceForCommandKey:cmdKey
																		 withParameters:parameters
																			withParser:^(NSDictionary* json) {
																				
																				NSNumber* count = json[@"count"];
																				NSLog(@"Expcted %@ sessions", count);
																				WSDojo* dojo = [DojoFinderWebServiceUtilites makeDojoFromResponse:[json objectForKey:@"dojo"]];
																				NSArray* sessionResponses = json[@"sessions"];
																				for (NSDictionary* response in sessionResponses) {
																					NSNumber* key = response[@"key"];
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
																				return [NSError errorWithDomain:SessionServiceErrorDomain code:DojoSessionWebServiceError userInfo:userInfo];
																			}
																							error:error];
	
	return sessions;
}

+(NSString*)doubleToString:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}


@end
