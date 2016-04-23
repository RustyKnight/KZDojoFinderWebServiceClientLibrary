//
//  RegionContactWebService.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 19/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "RegionContactWebService.h"
#import "DojoFinderWebServiceUtilites.h"
#import "DefaultWebServiceDelegate.h"

static WebServiceErrorFactory regionContactWebServiceErrorFactory = ^NSError * _Nonnull (NSDictionary * _Nonnull userInfo) {
	return [NSError errorWithDomain:RegionContactWebServiceErrorDomain
														 code:RegionContactWebServiceError
												 userInfo:userInfo];
};


@implementation RegionContactWebService {
}

+(void)pictureForRegionContactByKey:(NSInteger)key withConsume:(id<WebServiceConsumer>)consumer {
	
	NSString* cmdKey = @"PictureForRegionContactRequest";
	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
	[parameters setObject:[NSNumber numberWithInteger:key] forKey:@"key"];
	
	DefaultWebServiceDelegate* delegate =
	[DefaultWebServiceDelegate
	 serviceWithCommandKey:cmdKey
	 andParameters:parameters
	 andComplitationHandler:^NSObject * _Nullable (NSDictionary * _Nonnull json) {
		 NSNumber* count = json[@"count"];
		 NSLog(@"Expecting %@ pictures", count);
		 
		 return [DojoFinderWebServiceUtilites decodeImageFromJsonResponse:json
																															withKey:@"picture"];
	 }
	 andErrorHandler:regionContactWebServiceErrorFactory];
	
	[DojoFinderWebServiceUtilites executeWebServiceWithDelegate:delegate
																									andConsumer:consumer];
	
}

+(void)pictureForRegionContact:(WSRegionContact *)contact withConsume:(id<WebServiceConsumer>)consumer {
	[RegionContactWebService pictureForRegionContactByKey:[contact key]
																						withConsume:consumer];
}

+(void)regionContactForDojo:(id<Dojo>)dojo withConsume:(id<WebServiceConsumer>)consumer {
	[RegionContactWebService regionContactForRegion:[dojo region]
																			withConsume:consumer];
}

+(void)regionContactForRegion:(NSInteger)region withConsume:(id<WebServiceConsumer>)consumer {

	NSString* cmdKey = @"ContactForRegionRequest";
	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
	[parameters setObject:[NSNumber numberWithInteger:region] forKey:@"region"];
	
	DefaultWebServiceDelegate* delegate =
	[DefaultWebServiceDelegate
	 serviceWithCommandKey:cmdKey
	 andParameters:parameters
	 andComplitationHandler:^NSObject * _Nullable (NSDictionary * _Nonnull json) {
		 
		 NSNumber* count = json[@"count"];
		 NSLog(@"Expecting %@ contacts", count);
		 
		 NSDictionary* response = json[@"contact"];
		 NSNumber* key = response[@"key"];
		 NSString* name = response[@"name"];
		 NSString* phoneNumber = response[@"phone"];
		 NSString* email = response[@"email"];
		 NSString* facebook = response[@"facebook"];
		 NSNumber* region = response[@"region"];
		 
		 return [[WSRegionContact alloc] initWithKey:[key integerValue]
																							 name:name
																				phoneNumber:phoneNumber
																							email:email
																					 facebook:facebook
																						 region:region.intValue];
	 }
	 andErrorHandler:regionContactWebServiceErrorFactory];
	
	[DojoFinderWebServiceUtilites executeWebServiceWithDelegate:delegate
																									andConsumer:consumer];
	
}

//+(WSRegionContact* _Nullable)regionContactForRegion:(NSNumber* _Nonnull)region error:(NSError* _Nullable * _Nullable)error {
//	
//	NSString* cmdKey = @"ContactForRegion";
//	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
//	[parameters setObject:region forKey:@"region"];
//	
//	__block WSRegionContact* contact = nil;
//	[DojoFinderWebServiceUtilites executeWebServiceForCommandKey:cmdKey
//																								withParameters:parameters
//																										withParser:^(NSDictionary* json) {
//																											
//																											NSNumber* count = json[@"count"];
//																											NSLog(@"Expcted %@ contacts", count);
//																											
//																											NSDictionary* response = json[@"contact"];
//																											NSNumber* key = response[@"key"];
//																											NSString* name = response[@"name"];
//																											NSString* phoneNumber = response[@"phone"];
//																											NSString* email = response[@"email"];
//																											NSString* facebook = response[@"facebook"];
//																											NSNumber* region = response[@"region"];
//																											
//																											contact = [[WSRegionContact alloc] initWithKey:key
//																																																name:name
//																																												 phoneNumber:phoneNumber
//																																															 email:email
//																																														facebook:facebook
//																																															region:region.intValue];
//																										}
//																									errorFactory:^NSError *(NSDictionary *userInfo) {
//																										return [NSError errorWithDomain:RegionContactWebServiceErrorDomain code:RegionContactWebServiceError userInfo:userInfo];
//																									}
//																												 error:error];
//	
//	return contact;
//	
//}
//
//+(WSRegionContact* _Nullable)regionContactForDojo:(id<Dojo> _Nonnull)dojo error:(NSError* _Nullable * _Nullable)error {
//	return [RegionContactWebService regionContactForRegion:[NSNumber numberWithInt:[dojo region]] error:error];
//}
//
//
//+(UIImage*)pictureForRegionContact:(WSRegionContact*)region error:(NSError* _Nullable *)error {
//	return [RegionContactWebService pictureForRegionContactByKey:[region key] error:error];
//}
//
//+(UIImage*)pictureForRegionContactByKey:(NSNumber*)key error:(NSError* _Nullable *)error {
//	
//	NSString* cmdKey = @"PictureForRegionContact";
//	NSMutableDictionary<NSString*, NSObject*> *parameters = [[NSMutableDictionary alloc] init];
//	[parameters setObject:key forKey:@"key"];
//	
//	__block UIImage* imagePicture = nil;
//	[DojoFinderWebServiceUtilites executeWebServiceForCommandKey:cmdKey
//																								withParameters:parameters
//																										withParser:^(NSDictionary* json) {
//																											
//																											NSNumber* count = json[@"count"];
//																											NSLog(@"Expcted %@ pictures", count);
//																											
//																											NSDictionary* properties = [json objectForKey:@"picture"];
//																											if (properties) {
//																												NSLog(@"Load encoded image data");
//																												NSString* data = [properties objectForKey:@"picture"];
//																												NSLog(@"Decode image data");
//																												NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:data options:0];
//																												NSLog(@"Make image");
//																												imagePicture = [[UIImage alloc] initWithData:decodedData];
//																											}
//																										}
//																									errorFactory:^NSError *(NSDictionary *userInfo) {
//																										return [NSError errorWithDomain:RegionContactWebServiceErrorDomain code:RegionContactWebServiceError userInfo:userInfo];
//																									}
//																												 error:error];
//	
//	return imagePicture;
//}

@end
