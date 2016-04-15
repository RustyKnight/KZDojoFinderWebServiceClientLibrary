//
//  WSDojo.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KZDojoFinderLibrary/KZDojoFinderLibrary.h>

@interface WSDojo : NSObject<Dojo>
-(id)initWithKey:(NSNumber*)key name:(NSString*)name address:(NSString*)address region:(int)region latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;
@property (readonly, strong, nonatomic) NSNumber* key;
@end
