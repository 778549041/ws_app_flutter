//
//  QiniuUpload.m
//  qiniu_test
//
//  Created by lv on 2020/7/23.
//  Copyright © 2020 mzd. All rights reserved.
//

#import "QiniuUpload.h"
#import "QiniuSDK.h"

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
    //检查token 格式 否则会 崩溃
    BOOL success = [self tokenCheck:conf.token];
    if(success == NO){
        completionHandler(@{@"success":@(NO),@"statusCode":@(-10001),@"error":@"token Invalid format"});
        return;
    }
    
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
    
    
    [_upManager putFile:conf.filePath key:nil token:conf.token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if(info.ok)
        {
            NSMutableDictionary *res = [resp mutableCopy];
            res[@"success"] = @(YES);
            completionHandler(res);
            
        }
        else{
            completionHandler(@{@"success":@(NO),@"statusCode":@(info.statusCode),@"broken":@(info.broken),@"reqId":info.reqId,@"error":info.error.userInfo[@"error"],@"host":info.host,@"duration":@(info.duration),@"canceled":@(info.isCancelled)});
        }
        
    }
    option:option];
    
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
