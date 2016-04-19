//
//  RegionContactWebService.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 19/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "RegionContactWebService.h"
#import "DojoFinderWebServiceUtilites.h"

@implementation RegionContactWebService

+(UIImage*)pictureForRegionContact:(WSRegionContact*)region error:(NSError* _Nullable *)error {
	return [RegionContactWebService pictureForRegionContactByKey:[region key] error:error];
}

+(UIImage*)pictureForRegionContactByKey:(NSNumber*)key error:(NSError* _Nullable *)error {
	
	NSString* cmdKey = @"PictureForRegionContact";
	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
	[parameters setObject:key forKey:@"region"];
	
	__block UIImage* imagePicture = nil;
	[DojoFinderWebServiceUtilites executeWebServiceForCommandKey:cmdKey
																								withParameters:parameters
																										withParser:^(NSDictionary* json) {
																											
																											NSNumber* count = json[@"count"];
																											NSLog(@"Expcted %@ pictures", count);
																											
																											NSDictionary* properties = [json objectForKey:@"picture"];
																											if (properties) {
																												NSLog(@"Load encoded image data");
																												NSString* data = [properties objectForKey:@"picture"];
																												NSLog(@"Decode image data");
																												NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:data options:0];
																												NSLog(@"Make image");
																												imagePicture = [[UIImage alloc] initWithData:decodedData];
																											}
																										}
																									errorFactory:^NSError *(NSDictionary *userInfo) {
																										return [NSError errorWithDomain:SessionServiceErrorDomain code:RegionContactWebServiceError userInfo:userInfo];
																									}
																												 error:error];
	
	return imagePicture;
}

+(WSRegionContact*)regionContactForRegion:(NSNumber*)region error:(NSError* _Nullable *)error {
	return nil;
}

+(WSRegionContact*)regionContactByKey:(NSNumber*)key error:(NSError* _Nullable *)error {
	return nil;
}

@end
