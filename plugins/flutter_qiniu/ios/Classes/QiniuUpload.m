//
//  QiniuUpload.m
//  qiniu_test
//
//  Created by lv on 2020/7/23.
//  Copyright © 2020 mzd. All rights reserved.
//

#import "QiniuUpload.h"
#import "QiniuSDK.h"
#include <CommonCrypto/CommonCrypto.h>
#import "QN_GTM_Base64.h"

@interface QiniuUpload()
@property (nonatomic,strong) QNUploadManager *upManager;
@end

@implementation QiniuUpload

+ (instancetype)shared {
    static QiniuUpload *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _shared = [[super allocWithZone:NULL] init];
    });
    return _shared;
}

// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [QiniuUpload shared];
}

// 防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [QiniuUpload shared];
}


// 防止外部调用mutableCopy
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [QiniuUpload shared];
}

- (void)uploadConfig:(QiniuUploadConfig *)conf option:(QiniuUploadOption *)opt complete:(QiniuCompletionHandler)completionHandler;
{
//    //检查token 格式 否则会 崩溃
//    BOOL success = [self tokenCheck:conf.token];
//    if(success == NO){
//        completionHandler(@{@"success":@(NO),@"statusCode":@(-10001),@"error":@"token Invalid format"});
//        return;
//    }
    
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.useHttps = YES;
    }];
    
    QNUploadOption *option;
    
    if(opt){
        option = [[QNUploadOption alloc]initWithProgressHandler:^(NSString *key, float percent) {
            if(opt.progress != nil){
                opt.progress(key, percent);
            }
        }];
        
    }
    
    if(_upManager == nil){
        _upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    }
    
    
    [_upManager putFile:conf.filePath key:nil token:[self makeToken:conf.accessKey secretKey:conf.secretKey scope:conf.scope] complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if(info.ok)
        {
            NSMutableDictionary *res = [resp mutableCopy];
            res[@"success"] = @(YES);
            res[@"key"] = resp[@"key"];
            completionHandler(res);
            
        }
        else{
            completionHandler(@{@"success":@(NO),@"statusCode":@(info.statusCode),@"broken":@(info.broken),@"reqId":info.reqId,@"error":info.error.userInfo[@"error"],@"host":info.host,@"duration":@(info.duration),@"canceled":@(info.isCancelled)});
        }
        
    }
    option:option];
    
}

//获取token

- (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey scope:(NSString *)scope{
    
    const char *secretKeyStr = [secretKey UTF8String];
    NSString *policy = [self marshal:scope];
    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedPolicy = [QN_GTM_Base64 stringByWebSafeEncodingData:policyData padded:TRUE];
    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
    NSString *encodedDigest = [QN_GTM_Base64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",  accessKey, encodedDigest, encodedPolicy];
    
    return token;//得到了token
}


- (NSString *)marshal:(NSString *)scope {
    
    NSInteger _expire = 0;
    time_t deadline;
    time(&deadline);//返回当前系统时间
    deadline += (_expire > 0) ? _expire : 3600; // +3600秒,即默认token保存1小时.
    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:scope forKey:@"scope"];//根据
    [dic setObject:deadlineNumber forKey:@"deadline"];
    NSString *json = [self convertToJsonData:dic ];
    
    return json;
}

- (NSString *)convertToJsonData:(NSDictionary *)dict{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}


-(BOOL)tokenCheck:(NSString *)token
{
    NSRange rangeFirst = [token rangeOfString:@":"];
    if (rangeFirst.location == NSNotFound){
        return NO;
    }
    
    NSString *temp = [token substringWithRange:NSMakeRange(rangeFirst.location + 1, token.length - rangeFirst.location - 1)];
    NSRange rangeSecond = [temp rangeOfString:@":"];
    if (rangeSecond.location == NSNotFound)
    {
        return NO;
    }
    
    
    NSString *base64 = [temp substringWithRange:NSMakeRange(rangeSecond.location + 1, temp.length - rangeSecond.location - 1)];
    NSString *str = [self dencode:base64];
    if(str == nil || [str isEqualToString:@""]){
        return NO;
    }
    
    return YES;
}


- (NSString *)dencode:(NSString *)base64String
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}


@end
