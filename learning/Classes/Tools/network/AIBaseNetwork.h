//
//  AIBaseNetwork.h
//  learning
//
//  Created by 祥伟 on 2019/1/7.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIResponse.h"



#if PGY
#define MAINPATH @"http://10.214.182.130/gringotts"
#elif DEBUG
#define MAINPATH  @"http://10.214.182.130/gringotts"
#else
#define MAINPATH @"https://kyh.wandaloans.com/gringotts"
#endif

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AIRequestStatus) {
    
    AIRequestStatusSuccess                   = 200,
    AIRequestStatusFailure,
    //以下可以按照需求自定义模式
    AIRequestStatusTokenExpired              = 401//token失效
    
};

typedef NS_ENUM(NSInteger, AIRequestMethod) {
    
    AIRequestMethodGet,//default
    AIRequestMethodPUT,
    AIRequestMethodPOST,
    AIRequestMethodPATCH,
    AIRequestMethodDELETE,
    
};

typedef void (^AIRequestBlock)(AIRequestStatus requestStatus,AIResponse *response);

@interface AIBaseNetwork : NSObject

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSDictionary *parameters;

@property (nonatomic, copy) Class cls;

@property (nonatomic, assign) AIRequestMethod requestMethod;
//超时时间，默认60s
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

- (instancetype)initWithURL:(NSString *)url;

- (instancetype)initWithURL:(NSString *)url parameters:(nullable NSDictionary *)parameters;

- (instancetype)initWithURL:(NSString *)url parameters:(nullable NSDictionary *)parameters modelClass:(nullable Class)cls;

- (instancetype)initWithURL:(NSString *)url parameters:(nullable NSDictionary *)parameters modelClass:(nullable Class)cls requestMethod:(AIRequestMethod)requestMethod;

- (void)request:(AIRequestBlock)requestBlock;

//- (void)

@end



NS_ASSUME_NONNULL_END
