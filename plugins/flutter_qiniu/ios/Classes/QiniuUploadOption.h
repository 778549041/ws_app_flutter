//
//  QiniuUploadOption.h
//  qiniu_test
//
//  Created by lv on 2020/7/23.
//  Copyright © 2020 mzd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *    上传进度回调函数
 *
 *    @param key     上传时指定的存储key
 *    @param percent 进度百分比
 */
typedef void (^QiniuUpProgressHandler)(NSString *key, float percent);




@interface QiniuUploadOption : NSObject

@property (nonatomic,copy) QiniuUpProgressHandler progress;

@end

NS_ASSUME_NONNULL_END
