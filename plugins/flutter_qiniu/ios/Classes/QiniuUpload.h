//
//  QiniuUpload.h
//  qiniu_test
//
//  Created by lv on 2020/7/23.
//  Copyright © 2020 mzd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QiniuUploadConfig.h"
#import "QiniuUploadOption.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^QiniuCompletionHandler)(NSDictionary *result);

@interface QiniuUpload : NSObject

+ (instancetype)shared;
+ (instancetype)allocWithZone:(struct _NSZone *)zone;

- (void)uploadConfig:(QiniuUploadConfig *)conf option:(QiniuUploadOption *)opt complete:(QiniuCompletionHandler)completionHandler;



@end

NS_ASSUME_NONNULL_END
