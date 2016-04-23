//
//  WSSession.h
//  KZDojoFinderWebServiceClientLibrary
//
//  Created by Shane Whitehead on 15/04/2016.
//  Copyright © 2016 KaiZen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <KZDojoFinderLibrary/KZDojoFinderLibrary.h>

@interface WSSession : NSObject<Session>
-(id)initWithKey:(NSInteger)key
						dojo:(id<Dojo>)dojo
			 dayOfWeek:(NSNumber*)dayOfWeek
				 details:(NSString*)details
			 startTime:(NSNumber*)startTime
				 endTime:(NSNumber*)endTime
						type:(NSNumber*)type;
@property NSInteger key;
@end
