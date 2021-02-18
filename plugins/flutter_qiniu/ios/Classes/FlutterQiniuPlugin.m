#import "FlutterQiniuPlugin.h"
#import "QiniuUpload.h"

@implementation FlutterQiniuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel *channel =
    [FlutterMethodChannel methodChannelWithName:@"plugins.xiaoenai.com/flutter_qiniu"
                                binaryMessenger:[registrar messenger]];
    FlutterQiniuPlugin *instance = [[FlutterQiniuPlugin alloc] init];
    instance.channel = channel;
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([@"upload" isEqualToString:call.method]) {
        
        NSDictionary * dic = [self jsonToDictionary:call.arguments];
        NSString *key;
        
        if(dic[@"key"]){
            if(![dic[@"key"] isKindOfClass:NSNull.class]){
                key = dic[@"key"];
            }
        }
        
        QiniuUploadConfig *config = [[QiniuUploadConfig alloc]init];
        config.filePath = dic[@"filePath"];
        config.token = dic[@"token"];
        config.key = key;
        
        QiniuUploadOption *option = [[QiniuUploadOption alloc]init];
        __weak typeof(self) weakSelf = self;
        [option setProgress:^(NSString * _Nonnull key, float percent) {
            [weakSelf progress:key percent:percent];
        }];
        
        
        [[QiniuUpload shared] uploadConfig:config option:option complete:^(NSDictionary * _Nonnull res) {
            NSString *str = [self dictionaryToJson:res];
            result(str);
        }];
    } else {
        result(FlutterMethodNotImplemented);
    }
}


-(void)progress:(NSString * )key percent:(float)percent{
    if(self.channel != nil){
        NSMutableDictionary *args = [[NSMutableDictionary alloc]init];
        if(key != nil){
            args[@"key"] = key;
        }
        args[@"percent"] = @(percent);
        
        NSString *str = [self dictionaryToJson:args];
        
        [self.channel invokeMethod:@"progress" arguments:str];
    }
}



- (NSDictionary *)jsonToDictionary:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        return nil;
    }
    return dic;
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    if(jsonData){
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
        NSRange range = {0,jsonString.length};
        //去掉字符串中的空格
        [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
        NSRange range2 = {0,mutStr.length};
        //去掉字符串中的换行符
        [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
        
        
        NSString *character = nil;
        for (int i = 0; i < mutStr.length; i ++) {
            character = [mutStr substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:@"\\"])
                [mutStr deleteCharactersInRange:NSMakeRange(i, 1)];
        }
        
        return mutStr;
    }
    
    return nil;
}


@end
