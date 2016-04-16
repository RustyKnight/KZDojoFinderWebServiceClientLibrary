//
//  DojoWebServiceUtilites.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 14/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDojo.h"

@interface DojoWebServiceUtilites : NSObject
+(NSDictionary*)webServiceProperties;
+(WSDojo*)makeDojoWithKey:(NSNumber*)key name:(NSString*)name address:(NSString*)address region:(int)region latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;
+(WSDojo*)makeDojoFromResponse:(NSDictionary*)response;
@end
