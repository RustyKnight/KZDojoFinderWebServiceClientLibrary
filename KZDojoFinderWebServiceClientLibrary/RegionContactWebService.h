//
//  RegionContactWebService.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 19/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

@import UIKit;
#import "WSRegionContact.h"

static const NSString *SessionServiceErrorDomain = @"org.kiazen.dojofinder.webservice.regioncontact";

enum {
	RegionContactWebServiceError
};


@interface RegionContactWebService : NSObject
+(WSRegionContact*)regionContactForRegion:(NSNumber*)region error:(NSError* _Nullable *)error;
+(WSRegionContact*)regionContactByKey:(NSNumber*)key error:(NSError* _Nullable *)error;
+(UIImage*)pictureForRegionContactByKey:(NSNumber*)key error:(NSError* _Nullable *)error;
+(UIImage*)pictureForRegionContact:(WSRegionContact*)region error:(NSError* _Nullable *)error;
@end
