//
//  WebService.m
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 20/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import "WebService.h"
#import "DojoFinderWebServiceUtilites.h"
#import "WebServiceConsumer.h"

@interface WebService () <NSURLSessionDownloadDelegate, NSURLSessionTaskDelegate, NSURLSessionDelegate>//<NSURLSessionDataDelegate, NSURLSessionDelegate, NSURLSessionTaskDelegate>
@end

@implementation WebService  {
	id<WebServiceDelegate> _Nonnull _delegate;
	id<WebServiceConsumer> _Nonnull _consumer;
	float _downloadSize;
	float _bytesDownloaded;
}

-(id _Nullable)initWithDelegate:(id<WebServiceDelegate> _Nonnull)delegate andConsumer:(id<WebServiceConsumer> _Nonnull) consumer {
	if (self = [super init]) {
		_delegate = delegate;
		_consumer = consumer;
	}
	return self;
}

+(id _Nullable)serviceWithDelegate:(id<WebServiceDelegate> _Nonnull)delegate andConsumer:(id<WebServiceConsumer> _Nonnull) consumer {
	return [[WebService alloc] initWithDelegate:delegate andConsumer:consumer];
}

-(id<WebServiceDelegate> _Nonnull)delegate {
	return _delegate;
}

-(id<WebServiceConsumer> _Nonnull)consumer {
	return _consumer;
}

-(void)execute {
	NSDictionary *mainDictionary = [DojoFinderWebServiceUtilites webServiceProperties];
	
	NSString* serverAddress = [mainDictionary valueForKey:@"WebServerAddress"];
	NSString* request = [mainDictionary valueForKey:[self.delegate webServiceCommandKey]];
	NSString* serverScheme = [mainDictionary valueForKey:@"WebServerScheme"];
	NSNumber* serverPort = [mainDictionary valueForKey:@"WebServerPort"];
	
	NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
	urlComponents.scheme = serverScheme;
	urlComponents.host = serverAddress;
	urlComponents.path = request;
	urlComponents.port = serverPort;
	
	NSMutableArray<NSURLQueryItem*>* queryItems = [[NSMutableArray alloc] init];
	NSDictionary<NSString*, NSObject*>* parameters = [self.delegate webServiceParameters];
	for (NSString* key in [self.delegate webServiceParameters]) {
		NSObject* value = [parameters objectForKey:key];
		[queryItems addObject:
		 [WebService makeQueryItemForKey:key
														andValue:[NSString stringWithFormat:@"%@", value]]];
	}
	urlComponents.queryItems = queryItems;
	
	//	NSMutableArray* results;
	NSURL *url = urlComponents.URL;
	NSLog(@"%@", url);
	
	[self.consumer webServiceWillStart:self];
	NSURLSession* session = [NSURLSession
													 sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration
													 delegate:self
													 delegateQueue:[NSOperationQueue mainQueue]];
	NSURLSessionDownloadTask* task = [session downloadTaskWithURL:url];
	[task resume];
}

+(NSOperationQueue*)processingQueue {
	static NSOperationQueue* processingQueue = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		processingQueue = [[NSOperationQueue alloc] init];
	});
	return processingQueue;
}

-(void)downloadCompletedWithData:(NSData* _Nonnull)data {
	// Really don't want the processing to take place on the main thread
	if ([NSThread isMainThread]) {
		// I had been mucking around with dispatchq but thought this was simply
		// a better solution for my general needs
		// Yes, I did try using [NSOperationQueue mainQueue]],
		// but becaues it has tasks on the queue from which this is getting executed
		// it kind of back fired
		[[WebService processingQueue] addOperationWithBlock:^{
			[self downloadCompletedWithData:data];
		}];
		
	} else {
		// This is executed in the main thread...
		// Not sure if that's an issue or not...
		NSError* parseError;
		NSLog(@"Parse Json");
		NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
		if (!parseError) {
			NSString *status = [json objectForKey:@"status"];
			if ([@"ok" isEqualToString:status]) {
				NSLog(@"Process Result");
				NSObject* results = [self.delegate webServiceCompletedWithJson:json];
				NSLog(@"Complete request");
				dispatch_async(dispatch_get_main_queue(), ^{
					[self.consumer webService:self didCompleteWith:results];
				});
			} else {
				NSLog(@"Request failed");
				NSString *errorString = [json objectForKey:@"error"];
				NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorString};
				NSLog(@"Return with error of %@", errorString);
				dispatch_async(dispatch_get_main_queue(), ^{
					[self.consumer webService:self didFailWithError:[self.delegate webServiceErrorFromUserInfo:userInfo]];
				});
			}
		} else {
			dispatch_async(dispatch_get_main_queue(), ^{
				[self.consumer webService:self didFailWithError:parseError];
			});
		}
	}
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
	if (error) {
		[self.consumer webService:self didFailWithError:error];
	}
}

-(void)URLSession:(NSURLSession *)session
		 downloadTask:(NSURLSessionDownloadTask *)downloadTask
didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {
	// Hmmm... not sure I really care here...
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
	float progress = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
	[self.consumer webService:self progressDidChange:[NSNumber numberWithFloat:progress]];
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
	NSData* data = [NSData dataWithContentsOfURL:location];
	[self downloadCompletedWithData:data];
}

+(NSURLQueryItem*)makeQueryItemForKey:(NSString*)key andValue:(NSString*)value {
	return [[NSURLQueryItem alloc] initWithName:key value:value];
}

@end