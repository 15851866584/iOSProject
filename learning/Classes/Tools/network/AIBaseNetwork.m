//
//  AIBaseNetwork.m
//  learning
//
//  Created by 祥伟 on 2019/1/7.
//  Copyright © 2019年 wanda. All rights reserved.
//

#import "AIBaseNetwork.h"
#import <YYModel.h>
#import <AFNetworking.h>

@implementation AIBaseNetwork

- (instancetype)initWithURL:(NSString *)url{
    return [self initWithURL:url parameters:nil modelClass:nil];
}

- (instancetype)initWithURL:(NSString *)url parameters:(nullable NSDictionary *)parameters{
    return [self initWithURL:url parameters:parameters modelClass:nil];
}

- (instancetype)initWithURL:(NSString *)url parameters:(NSDictionary *)parameters modelClass:(nullable Class)cls{
    return [self initWithURL:url parameters:parameters modelClass:cls requestMethod:AIRequestMethodGet];
}

- (instancetype)initWithURL:(NSString *)url parameters:(nullable NSDictionary *)parameters modelClass:(nullable Class)cls requestMethod:(AIRequestMethod)requestMethod{
    if (self = [super init]) {
        _url = url;
        _cls = cls;
        _parameters = parameters;
        _requestMethod = requestMethod;
    }
    return self;
}

- (AFHTTPSessionManager *)shareManager{
    NSURL *baseUrl = [NSURL URLWithString:MAINPATH];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    [config setHTTPAdditionalHeaders:@{@"Content-Type":@"application/json;text/html"}];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseUrl sessionConfiguration:config];
    manager.requestSerializer.timeoutInterval = _timeoutInterval;
    return manager;
}

- (void)request:(AIRequestBlock)requestBlock{
    AFHTTPSessionManager *manager = [self shareManager];
    AIResponse *response = [AIResponse new];
    response.requestUrl = _url;
    response.responseModelClass = _cls;
    response.requestParameters = _parameters;
    
    
    switch (_requestMethod) {
        case AIRequestMethodGet:
        {
            [manager GET:self.url parameters:self.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self response:response success:responseObject task:task requestBlock:requestBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self response:response failure:error task:task requestBlock:requestBlock];
            }];
        }
            break;
            case AIRequestMethodPUT:
        {
            [manager PUT:self.url parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self response:response success:responseObject task:task requestBlock:requestBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self response:response failure:error task:task requestBlock:requestBlock];
            }];
        }
        case AIRequestMethodPOST:
        {
            [manager POST:self.url parameters:self.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self response:response success:responseObject task:task requestBlock:requestBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self response:response failure:error task:task requestBlock:requestBlock];
            }];
        }
            case AIRequestMethodPATCH:
        {
            [manager PATCH:self.url parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self response:response success:responseObject task:task requestBlock:requestBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self response:response failure:error task:task requestBlock:requestBlock];
            }];
        }
        case AIRequestMethodDELETE:
        {
            [manager DELETE:self.url parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self response:response success:responseObject task:task requestBlock:requestBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self response:response failure:error task:task requestBlock:requestBlock];
            }];
        }
        default:
            break;
    }
    
}

- (void)response:(AIResponse *)response success:(id)responseObject task:(NSURLSessionDataTask *)task requestBlock:(AIRequestBlock)requestBlock{
    response.task = task;
    response.responseObject = responseObject;
    if (response.responseModelClass) {
        NSMutableArray *responseArray = nil;
        if (![responseObject isKindOfClass:[NSArray class]]) {
            [responseArray addObject:responseObject];
        }
        response.responseObject = [NSArray yy_modelArrayWithClass:response.responseModelClass json:responseArray];
    }
    
    requestBlock(AIRequestStatusSuccess,response);
}

- (void)response:(AIResponse *)response failure:(NSError *)error task:(NSURLSessionDataTask *)task requestBlock:(AIRequestBlock)requestBlock{
    response.task = task;
    response.error = error;
    requestBlock(AIRequestStatusFailure,response);
}

@end
