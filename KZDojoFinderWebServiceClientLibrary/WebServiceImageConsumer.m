//
//  WebServiceImageConsumer.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 21/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "WebServiceImageConsumer.h"

@implementation WebServiceImageConsumer {
	id<ImageConsumer> _imageConsumer;
}
-(id _Nullable)initWithImageConsumer:(id<ImageConsumer> _Nonnull) consumer {
	self = [super init];
	if (self) {
		_imageConsumer = consumer;
	}
	return self;
	
}

+(id _Nullable)withImageConsumer:(id<ImageConsumer> _Nonnull) consumer {
	return [[WebServiceImageConsumer alloc] initWithImageConsumer:consumer];
}

-(void)webServiceProgress:(float)progress {
	
}

-(void)webServiceCompletedWith:(NSObject *)data {
	if (data) {
		if ([data isKindOfClass:[UIImage class]]) {
			UIImage* image = (UIImage*)data;
			[_imageConsumer imageWasLoaded:image];
		}
	} else {
		[_imageConsumer imageWasLoaded:nil];
	}
}

-(void)webServiceFailedWithError:(NSError *)error {
	[_imageConsumer imageFailedWithError:error];
}

@end
