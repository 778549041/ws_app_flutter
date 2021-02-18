//
//  QiniuUploadConfig.h
//  qiniu_test
//
//  Created by lv on 2020/7/23.
//  Copyright © 2020 mzd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QiniuUploadConfig : NSObject

/// 从服务端SDK获取token
@property (nonatomic,strong) NSString *token;

/// 指定存储服务上的文件名，或nil
@property (nonatomic,strong) NSString *key;

/// 要上传的文件路径
@property (nonatomic,strong) NSString *filePath;

@end

NS_ASSUME_NONNULL_END
