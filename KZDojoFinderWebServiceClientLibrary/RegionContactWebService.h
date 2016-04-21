//
//  RegionContactWebService.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 19/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

@import UIKit;
#import "WSRegionContact.h"
#import "WebServiceConsumer.h"

static NSString* _Nonnull const RegionContactWebServiceErrorDomain = @"org.kiazen.dojofinder.webservice.regioncontact";

enum {
	RegionContactWebServiceError
};


@interface RegionContactWebService : NSObject
//+(WSRegionContact* _Nullable)regionContactForRegion:(NSNumber* _Nonnull)region error:(NSError* _Nullable * _Nullable)error;
//+(WSRegionContact* _Nullable)regionContactForDojo:(id<Dojo> _Nonnull)key error:(NSError* _Nullable * _Nullable)error;
//+(UIImage* _Nullable)pictureForRegionContactByKey:(NSNumber* _Nonnull)key error:(NSError* _Nullable * _Nullable)error;
//+(UIImage* _Nullable)pictureForRegionContact:(WSRegionContact* _Nonnull)region error:(NSError* _Nullable * _Nullable)error;

+(void)regionContactForRegion:(NSNumber* _Nonnull)region
									withConsume:(id<WebServiceConsumer> _Nonnull)consumer;
+(void)regionContactForDojo:(id<Dojo> _Nonnull)dojo
									withConsume:(id<WebServiceConsumer> _Nonnull)consumer;

+(void)pictureForRegionContactByKey:(NSNumber* _Nonnull)key
												withConsume:(id<WebServiceConsumer> _Nonnull)consumer;
+(void)pictureForRegionContact:(WSRegionContact* _Nonnull)contact
												withConsume:(id<WebServiceConsumer> _Nonnull)consumer;

@end
