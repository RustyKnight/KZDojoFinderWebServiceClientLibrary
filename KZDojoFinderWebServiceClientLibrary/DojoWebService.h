//
//  KZWSDojoFactory.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 13/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

@import MapKit;
#import <Foundation/Foundation.h>
#import "WSDojo.h"

static NSString* _Nonnull const DojoWebServiceErrorDomain = @"org.kiazen.dojofinder.webservice.dojo";
enum {
	DojoWebServiceError
};


@interface DojoWebService : NSObject
+(NSArray<WSDojo*>* _Nonnull)dojosWithin:(CLLocationCoordinate2D)regionFrom
																			to:(CLLocationCoordinate2D)regionTo
																	 error:(NSError* _Nullable *  _Nonnull)error;
+(UIImage* _Nullable)pictureForDojo:(WSDojo*  _Nonnull)dojo error:(NSError* _Nullable * _Nonnull)error;
+(UIImage* _Nullable)pictureForDojoByKey:(NSNumber* _Nonnull)dojoKey error:(NSError* _Nullable * _Nonnull)error;
@end
