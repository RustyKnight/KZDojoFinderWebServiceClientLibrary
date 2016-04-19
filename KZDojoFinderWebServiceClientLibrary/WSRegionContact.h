//
//  WSRegionContact.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 19/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KZDojoFinderLibrary/KZDojoFinderLibrary.h>

@interface WSRegionContact : NSObject<RegionalContact>
-(id)initWithKey:(NSNumber*)key name:(NSString*)name phoneNumber:(NSString*)phoneNumber email:(NSString*)email facebook:(NSString*)facebook region:(int)region;
@property (readonly, strong, nonatomic) NSNumber* key;
@end
