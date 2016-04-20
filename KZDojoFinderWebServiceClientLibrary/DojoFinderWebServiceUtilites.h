//
//  DojoWebServiceUtilites.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 14/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDojo.h"

static NSString* _Nonnull const DojoServiceErrorDomain = @"dojo";

typedef void (^WebServiceParser)(NSDictionary* _Nonnull);
typedef NSError* _Nullable (^WebServiceErrorFactory)(NSDictionary* _Nonnull);

@interface DojoFinderWebServiceUtilites : NSObject
+(NSDictionary* _Nonnull)webServiceProperties;
+(WSDojo* _Nullable)makeDojoWithKey:(NSNumber*  _Nonnull)key
															 name:(NSString*  _Nonnull)name
														address:(NSString*  _Nonnull)address
														 region:(int)region
													 latitude:(CLLocationDegrees)latitude
													longitude:(CLLocationDegrees)longitude;
+(WSDojo* _Nullable)makeDojoFromResponse:(NSDictionary* _Nonnull)response;
+(void)executeWebServiceForCommandKey:(NSString* _Nonnull)cmdKey
											 withParameters:(NSDictionary<NSString*, NSObject*>* _Nonnull)parameters
													 withParser:(WebServiceParser _Nonnull)parser
												 errorFactory:(WebServiceErrorFactory _Nonnull)errorFactory
																error:(NSError* _Nullable* _Nonnull)error;
+(NSURLQueryItem* _Nonnull)makeQueryItemForKey:(NSString* _Nonnull)key andValue:(NSString* _Nonnull)value;
@end
