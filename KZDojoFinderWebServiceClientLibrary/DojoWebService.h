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

NSString *DojoWebServiceErrorDomain = @"org.kiazen.dojofinder.webservice.dojo";

enum {
	DojoWebServiceWebServerError
};

@interface DojoWebService : NSObject
+(NSArray<WSDojo*>*)dojosWithin:(CLLocationCoordinate2D)regionFrom to:(CLLocationCoordinate2D)regionTo error:(NSError* _Nullable *)error;
@end
