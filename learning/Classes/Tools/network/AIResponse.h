//
//  AIResponse.h
//  learning
//
//  Created by 祥伟 on 2019/1/8.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AIResponse : NSObject

@property (nonatomic, copy) NSArray *responseObject;

@property (nonatomic, copy) NSString *errorMessage;

@property (nonatomic, copy) NSError *error;

@property (nonatomic, copy) NSURLSessionDataTask *task;

@property (nonatomic) NSProgress *downloadProgress;

@property (nonatomic, copy) Class responseModelClass;

@property (nonatomic, copy) NSString *requestUrl;

@property (nonatomic, copy) NSDictionary *requestParameters;

@end

NS_ASSUME_NONNULL_END
