//
//  DojoWebServiceUtilites.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 14/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDojo.h"

static const NSString *DojoServiceErrorDomain = @"dojo";

typedef void (^WebServiceParser)(NSDictionary*);
typedef NSError* (^WebServiceErrorFactory)(NSDictionary*);

@interface DojoFinderWebServiceUtilites : NSObject
+(NSDictionary*)webServiceProperties;
+(WSDojo*)makeDojoWithKey:(NSNumber*)key name:(NSString*)name address:(NSString*)address region:(int)region latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;
+(WSDojo*)makeDojoFromResponse:(NSDictionary*)response;
+(void)executeWebServiceForCommandKey:(NSString *)cmdKey
											 withParameters:(NSDictionary<NSString*, NSObject*>*)parameters
													 withParser:(WebServiceParser)parser
												 errorFactory:(WebServiceErrorFactory)errorFactory
																error:(NSError* _Nullable*)error;
+(NSURLQueryItem*)makeQueryItemForKey:(NSString*)key andValue:(NSString*)value;
@end
