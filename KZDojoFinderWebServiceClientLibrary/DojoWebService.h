//
//  KZWSDojoFactory.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 13/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

@import MapKit;
#import <KZDojoFinderLibrary/KZDojoFinderLibrary.h>
#import "WSDojo.h"
#import "WebServiceConsumer.h"

static NSString* _Nonnull const DojoWebServiceErrorDomain = @"org.kiazen.dojofinder.webservice.dojo";
enum {
	DojoWebServiceError
};


@interface DojoWebService : NSObject
//+(NSArray<WSDojo*>* _Nonnull)dojosWithin:(CLLocationCoordinate2D)regionFrom
//																			to:(CLLocationCoordinate2D)regionTo
//																	 error:(NSError* _Nullable *  _Nonnull)error;

+(void)dojosWithin:(CLLocationCoordinate2D)regionFrom
								to:(CLLocationCoordinate2D)regionTo
			 withConsumer:(id<WebServiceConsumer> _Nonnull)consumer;

+(void)pictureForDojo:(WSDojo* _Nonnull)dojo withConsumer:(id<WebServiceConsumer> _Nonnull)consumer;
+(void)pictureForDojoByKey:(NSInteger)dojoKey withConsumer:(id<WebServiceConsumer> _Nonnull)consumer;
@end
